module "test-deploy" {
  source         = "./terraform-vsphere-vsphere-clone-cloudinit"
  datacenter     = "Datacenter"
  datastore_name = "vsanDatastore"
  cluster        = "Cluster"
  vm_network     = "seg-general"
  template       = true
  template_name  = "linux-ubuntu-server-20-04-lts-1651168080"
  deployment_vm_data = {
    vm1 = {
      disk_size = 40
      memory    = 2048
      metadata  = "metadata.yaml"
      name      = "test-deploy"
      num_cpus  = 2
      user_data_map = {
        script1 = {
          content_type = "text/x-shellscript"
          file_path    = "userdata.sh"
          vars = {
            TEST = "This is a test"
          }
        }
        script2 = {
          content_type = "text/x-shellscript"
          file_path    = "userdata2.sh"
          vars = {
            TEST2 = "This is a test 2"
          }
        }
      }
    }
  }
}