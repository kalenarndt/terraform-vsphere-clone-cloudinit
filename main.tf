# data block to fetch the datacenter id
data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

# data block to fetch target datastore id
data "vsphere_datastore" "datastore" {
  count         = var.datastore == true && var.datastore_cluster == false ? 1 : 0
  name          = var.datastore_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore_cluster" "datastore_cluster" {
  count         = var.datastore == false && var.datastore_cluster == false ? 1 : 0
  name          = var.datastore_cluster_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

# data block to fetch target compute cluster root resource pool id
data "vsphere_compute_cluster" "compute_cluster" {
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

# data block to fetch target deployment network details
data "vsphere_network" "deployment_network" {
  name          = var.vm_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

# data block to fetch the deployment vm template
data "vsphere_virtual_machine" "deployment_template" {
  count         = var.template ? 1 : 0
  name          = var.template_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_content_library" "content_library" {
  count = var.content_library ? 1 : 0
  name  = var.content_library_name
}

data "vsphere_content_library_item" "item" {
  count      = var.content_library ? 1 : 0
  library_id = data.vsphere_content_library.content_library[0].id
  type       = var.content_library_template_type
  name       = var.content_library_name
}

data "vsphere_tag_category" "tag_category" {
  for_each = var.tags ? var.deployment_vm_data : {}
  name     = each.value.tag_category
}

data "vsphere_tag" "deployment_tag" {
  for_each    = var.tags ? var.deployment_vm_data : {}
  name        = each.value.tag_name
  category_id = data.vsphere_tag_category.tag_category[each.key].id
}

data "cloudinit_config" "user_data" {
  for_each      = var.deployment_vm_data
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = file("${path.cwd}/${each.value.user_data}")
  }
}

resource "vsphere_virtual_machine" "deployed-vm" {
  for_each             = var.deployment_vm_data
  name                 = "${var.vm_prefix}${each.value.name}"
  resource_pool_id     = data.vsphere_compute_cluster.compute_cluster.resource_pool_id
  datastore_id         = var.datastore == true && var.datastore_cluster == false ? data.vsphere_datastore.datastore[0].id : null
  datastore_cluster_id = var.datastore == false && var.datastore_cluster == true ? data.vsphere_datastore_cluster.datastore_cluster[0].id : null
  firmware             = var.content_library == false ? data.vsphere_virtual_machine.deployment_template[0].firmware : var.firmware
  folder               = var.folder_path != null ? var.folder_path : null
  num_cpus             = each.value.num_cpus
  memory               = each.value.memory
  guest_id             = var.content_library == false ? data.vsphere_virtual_machine.deployment_template[0].guest_id : null
  scsi_type            = var.content_library == false ? data.vsphere_virtual_machine.deployment_template[0].scsi_type : var.scsi_type
  tags                 = var.tags ? [data.vsphere_tag.deployment_tag[each.key].id] : null

  network_interface {
    network_id   = data.vsphere_network.deployment_network.id
    adapter_type = var.content_library == false ? data.vsphere_virtual_machine.deployment_template[0].network_interface_types[0] : var.network_adapter_type
  }


  ## Currently working
  dynamic "disk" {
    for_each = var.content_library == false ? data.vsphere_virtual_machine.deployment_template[0].disks : []
    content {
      label            = "placeholder"
      size             = var.content_library == false ? (each.value.disk_size != "" ? each.value.disk_size : data.vsphere_virtual_machine.deployment_template[0].disks.0.size) : each.value.disk_size
      eagerly_scrub    = var.content_library == false ? data.vsphere_virtual_machine.deployment_template[0].disks.0.eagerly_scrub : null
      thin_provisioned = var.thin_provision
    }
  }

  clone {
    template_uuid = var.content_library == false ? data.vsphere_virtual_machine.deployment_template[0].id : data.vsphere_content_library_item.item[0].id
    linked_clone  = var.linked_clone == true && var.content_library_template_type != "ovf" ? var.linked_clone : false #forcing a bool type constraint so this has to be true / false instead of 1 0
  }

  extra_config = {
    "guestinfo.metadata"          = base64gzip(file("${path.cwd}/${each.value.metadata}"))
    "guestinfo.metadata.encoding" = "gzip+base64"
    "guestinfo.userdata"          = data.cloudinit_config.user_data[each.key].rendered
    "guestinfo.userdata.encoding" = "gzip+base64"
  }

  lifecycle {
    ignore_changes = [
      annotation,
      clone[0].template_uuid,
      extra_config,
    ]
  }
}
