# data block to fetch the datacenter id
data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

# data block to fetch target datastore id
data "vsphere_datastore" "datastore" {
  for_each      = length(var.datastore) >= 1 ? { "datastore" : "" } : {}
  name          = var.datastore
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
  name          = var.template_name
  datacenter_id = data.vsphere_datacenter.dc.id
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

data "vsphere_datastore_cluster" "dsc" {
  for_each      = length(var.datastore_cluster) >= 1 ? { "dsc" : "" } : {}
  name          = var.datastore_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
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
  datastore_id         = var.datastore != "" ? data.vsphere_datastore.datastore["datastore"].id : null
  datastore_cluster_id = var.datastore_cluster != "" ? data.vsphere_datastore_cluster.dsc["dsc"].id : null
  folder               = var.folder_path != "" ? var.folder_path : ""
  firmware             = data.vsphere_virtual_machine.deployment_template.firmware
  num_cpus             = each.value.num_cpus
  memory               = each.value.memory
  guest_id             = data.vsphere_virtual_machine.deployment_template.guest_id
  scsi_type            = data.vsphere_virtual_machine.deployment_template.scsi_type
  tags                 = var.tags ? [data.vsphere_tag.deployment_tag[each.key].id] : null

  network_interface {
    network_id   = data.vsphere_network.deployment_network.id
    adapter_type = data.vsphere_virtual_machine.deployment_template.network_interface_types[0]
  }

  disk {
    label            = "os"
    size             = each.value.disk_size != "" ? each.value.disk_size : data.vsphere_virtual_machine.deployment_template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.deployment_template.disks.0.eagerly_scrub
    thin_provisioned = var.thin_provision
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.deployment_template.id
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
