module "vault" {
  source = "./modules/cloud-init"
  datacenter = "Black Mesa"
  datastore = "ESXi2-SSD"
  cluster = "Compute"
  vm_prefix = "hc-"
  template_name = "HashiCorp-linux-ubuntu-server-20-04-lts"
  folder_path = "HashiCorp/Workloads"
  vm_network = "az1|hashicorp-01|hashicorp-network-172.23.200"
  deployment_vm_data = {
    "vault" = {
      disk_size = 50
      memory = 8096
      metadata = "metadata.yaml"
      name = "cts"
      num_cpus = 2
      user_data = "userdata.sh"
    }
  }
}
