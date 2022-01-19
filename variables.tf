variable "deployment_vm_data" {
  type = map(object({
    name         = string
    num_cpus     = number
    memory       = number
    disk_size    = number
    user_data    = string
    metadata     = string
    tag_category = optional(string)
    tag_name     = optional(string)
  }))
  description = "(Required) Map containing the configuration for the virtual machines"
}


variable "datacenter" {
  description = "variable for the datacenter where the VMs will be deployed"
  type        = string
}

variable "datastore" {
  description = "variable for the datastore that the VMs will be placed on"
  type        = string
}

variable "cluster" {
  description = "variable for the vsphere cluster that the VMs will be placed in"
  type        = string
}

variable "vm_network" {
  description = "(Required) Target network where the VMs will be deployed"
  type        = string
}

variable "template_name" {
  description = "variable for the template name that VMs will be cloned from"
  type        = string
}

variable "folder_path" {
  description = "(Optional) variable for the folder path that will be used when deploying workloads"
  type        = string
  default     = ""
}

variable "thin_provision" {
  type        = bool
  description = "(Optional) Determines if the VM that will be created will be thin or thick provisioned"
  default     = true
}

variable "tags" {
  type        = bool
  description = "(Optional) Conditional that allows for the setting of tags on a VM"
  default     = false
}

variable "vm_prefix" {
  type        = string
  description = "(Optional) Prefix that will be prepended to the VMs that you deploy"
  default     = ""
}
