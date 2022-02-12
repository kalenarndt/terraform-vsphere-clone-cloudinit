# terraform-vsphere-vsphere-clone-cloudinit

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_vsphere"></a> [vsphere](#requirement\_vsphere) | >=1.26.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | 2.2.0 |
| <a name="provider_vsphere"></a> [vsphere](#provider\_vsphere) | 2.0.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vsphere_virtual_machine.deployed-vm](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/resources/virtual_machine) | resource |
| [cloudinit_config.user_data](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |
| [vsphere_compute_cluster.compute_cluster](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/compute_cluster) | data source |
| [vsphere_content_library.content_library](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/content_library) | data source |
| [vsphere_content_library_item.cl_item](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/content_library_item) | data source |
| [vsphere_datacenter.dc](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/datacenter) | data source |
| [vsphere_datastore.datastore](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/datastore) | data source |
| [vsphere_datastore_cluster.datastore_cluster](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/datastore_cluster) | data source |
| [vsphere_network.deployment_network](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/network) | data source |
| [vsphere_tag.deployment_tag](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/tag) | data source |
| [vsphere_tag_category.tag_category](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/tag_category) | data source |
| [vsphere_virtual_machine.deployment_template](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/virtual_machine) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster"></a> [cluster](#input\_cluster) | variable for the vsphere cluster that the VMs will be placed in | `string` | n/a | yes |
| <a name="input_content_library"></a> [content\_library](#input\_content\_library) | (Optional) Conditional that allows for the use of a Content Library when deploying VMs | `bool` | `false` | no |
| <a name="input_content_library_name"></a> [content\_library\_name](#input\_content\_library\_name) | (Optional) Name of the Content Library that will be used when deploying VMs. Required if var.content\_library is set to true. | `string` | `""` | no |
| <a name="input_content_library_template_type"></a> [content\_library\_template\_type](#input\_content\_library\_template\_type) | (Optional) Type of template in the Content Library that will be used when deploying VMs. Required if var.content\_library is set to true. | `string` | `""` | no |
| <a name="input_datacenter"></a> [datacenter](#input\_datacenter) | variable for the datacenter where the VMs will be deployed | `string` | n/a | yes |
| <a name="input_datastore"></a> [datastore](#input\_datastore) | (Optional) Conditional that allows for the use of Datastores when deploying VMs | `bool` | `true` | no |
| <a name="input_datastore_cluster"></a> [datastore\_cluster](#input\_datastore\_cluster) | (Optional) Conditional that allows for the use of Datastore Cluster when deploying VMs | `bool` | `false` | no |
| <a name="input_datastore_cluster_name"></a> [datastore\_cluster\_name](#input\_datastore\_cluster\_name) | (Optional) Name of the Datastore Cluster that will be used when deploying VMs. Required if var.datastore\_cluster is set to true. | `string` | `""` | no |
| <a name="input_datastore_name"></a> [datastore\_name](#input\_datastore\_name) | (Optional) Name of the datastore that will be used when deploying VMs. Required if var.datastore is set to true. | `string` | `""` | no |
| <a name="input_deployment_vm_data"></a> [deployment\_vm\_data](#input\_deployment\_vm\_data) | (Required) Map containing the configuration for the virtual machines | <pre>map(object({<br>    name         = string<br>    num_cpus     = number<br>    memory       = number<br>    disk_size    = number<br>    user_data    = string<br>    metadata     = string<br>    tag_category = optional(string)<br>    tag_name     = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_firmware"></a> [firmware](#input\_firmware) | (Optional) Bios type that will be used when creating the VM | `string` | `""` | no |
| <a name="input_folder_path"></a> [folder\_path](#input\_folder\_path) | (Optional) variable for the folder path that will be used when deploying workloads | `string` | `""` | no |
| <a name="input_linked_clone"></a> [linked\_clone](#input\_linked\_clone) | (Optional) Conditional that determines if a cloned VM will be deployed as a linked clone | `bool` | `false` | no |
| <a name="input_network_adapter_type"></a> [network\_adapter\_type](#input\_network\_adapter\_type) | (Optional) Network adapter type  that will be used when creating the VM | `string` | `""` | no |
| <a name="input_scsi_type"></a> [scsi\_type](#input\_scsi\_type) | (Optional) SCSI Controller that will be used when creating the VM | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Conditional that allows for the setting of tags on a VM | `bool` | `false` | no |
| <a name="input_template"></a> [template](#input\_template) | (Optional) Conditional that determines if a template will be used as the source for the VMs | `bool` | `true` | no |
| <a name="input_template_name"></a> [template\_name](#input\_template\_name) | (Optional) Name of the template that the VMs will be cloned from. Required if var.template is set to true | `string` | `""` | no |
| <a name="input_thin_provision"></a> [thin\_provision](#input\_thin\_provision) | (Optional) Conditional that determines if  the VM that will be created will be thin or thick provisioned | `bool` | `true` | no |
| <a name="input_vm_network"></a> [vm\_network](#input\_vm\_network) | (Required) Target network where the VMs will be deployed | `string` | n/a | yes |
| <a name="input_vm_prefix"></a> [vm\_prefix](#input\_vm\_prefix) | (Optional) Prefix that will be prepended to the VMs that you deploy | `string` | `""` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
