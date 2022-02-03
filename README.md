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
| [vsphere_datacenter.dc](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/datacenter) | data source |
| [vsphere_datastore.datastore](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/datastore) | data source |
| [vsphere_datastore_cluster.dsc](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/datastore_cluster) | data source |
| [vsphere_network.deployment_network](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/network) | data source |
| [vsphere_tag.deployment_tag](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/tag) | data source |
| [vsphere_tag_category.tag_category](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/tag_category) | data source |
| [vsphere_virtual_machine.deployment_template](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/virtual_machine) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster"></a> [cluster](#input\_cluster) | variable for the vsphere cluster that the VMs will be placed in | `string` | n/a | yes |
| <a name="input_datacenter"></a> [datacenter](#input\_datacenter) | variable for the datacenter where the VMs will be deployed | `string` | n/a | yes |
| <a name="input_datastore"></a> [datastore](#input\_datastore) | Variable for the datastore that the VMs will be placed on | `string` | `""` | no |
| <a name="input_datastore_cluster"></a> [datastore\_cluster](#input\_datastore\_cluster) | (Optional) Conditional that when set to true deploys the VMs on a Datastore Cluster | `string` | `""` | no |
| <a name="input_deployment_vm_data"></a> [deployment\_vm\_data](#input\_deployment\_vm\_data) | (Required) Map containing the configuration for the virtual machines | <pre>map(object({<br>    name         = string<br>    num_cpus     = number<br>    memory       = number<br>    disk_size    = number<br>    user_data    = string<br>    metadata     = string<br>    tag_category = optional(string)<br>    tag_name     = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_folder_path"></a> [folder\_path](#input\_folder\_path) | (Optional) variable for the folder path that will be used when deploying workloads | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Conditional that allows for the setting of tags on a VM | `bool` | `false` | no |
| <a name="input_template_name"></a> [template\_name](#input\_template\_name) | variable for the template name that VMs will be cloned from | `string` | n/a | yes |
| <a name="input_thin_provision"></a> [thin\_provision](#input\_thin\_provision) | (Optional) Determines if the VM that will be created will be thin or thick provisioned | `bool` | `true` | no |
| <a name="input_vm_network"></a> [vm\_network](#input\_vm\_network) | (Required) Target network where the VMs will be deployed | `string` | n/a | yes |
| <a name="input_vm_prefix"></a> [vm\_prefix](#input\_vm\_prefix) | (Optional) Prefix that will be prepended to the VMs that you deploy | `string` | `""` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
