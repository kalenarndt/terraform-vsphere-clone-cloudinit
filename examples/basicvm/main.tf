module "vault" {
  source            = "github.com/kalenarndt/terraform-vsphere-vsphere-clone-cloudinit"
  datacenter        = "Black Mesa"
  datastore_cluster = "Local"
  cluster           = "Compute"
  vm_prefix         = "hc-"
  template_name     = "linux-ubuntu-server-20-04-lts"
  folder_path       = "HashiCorp/Workloads"
  vm_network        = "seg-web"
  deployment_vm_data = {
    "vault" = {
      disk_size = 50
      memory    = 8096
      metadata  = "metadata.yaml"
      name      = "cts"
      num_cpus  = 2
      user_data = "userdata.sh"
    }
  }
}
