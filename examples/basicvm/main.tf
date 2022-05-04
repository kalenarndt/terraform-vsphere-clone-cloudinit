module "test-deploy" {
  source         = "github.com/kalenarndt/terraform-vsphere-clone-cloudinit"
  datacenter     = "Datacenter"
  datastore_name = "vsanDatastore"
  cluster        = "Cluster"
  vm_network     = "seg-general"
  template       = true
  template_name  = "linux-ubuntu-server-20-04-lts-1651168080"
  deployment_vm_data = {
    vm1 = {
      disk_size = 40            # The size of the disk that will be allocated to the VM
      memory    = 2048          # Amount of memory that will be allocated to the VM in mb
      name      = "test-deploy" # Name of the VM that we will be  creating
      num_cpus  = 2             # Number of vCPUs that will be allocated
      metadata = [{
        file_path = "metadata.yaml" # Metadata file that will be used
        vars = {
          hostname = "test-deploy" # Key and Value we are replacing in our Terraform run for the metadata file
        }
      }]
      user_data = {
        script1 = {
          content_type = "text/x-shellscript" # Type of file we are passing in
          file_path    = "userdata.sh"        # Name of the file to template
          vars = {
            TEST  = "This is a test" # Key and value we are replacing when doing our Terraform run in the script
            TEST2 = "is it?"         # Key and value we are replacing when doing our Terraform run in the script
          }
        }
        script2 = {
          content_type = "text/x-shellscript" # Type of file we are passing in
          file_path    = "userdata2.sh"       # Name of the file to template
          vars = {
            TEST3 = "This is a test 2" # Key and value we are replacing when doing our Terraform run in the script
          }
        }
      }
    }
  }
}