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



variable "cluster" {
  description = "variable for the vsphere cluster that the VMs will be placed in"
  type        = string
}

variable "vm_network" {
  description = "(Required) Target network where the VMs will be deployed"
  type        = string
}



variable "folder_path" {
  description = "(Optional) variable for the folder path that will be used when deploying workloads"
  type        = string
  default     = ""
}

variable "vm_prefix" {
  type        = string
  description = "(Optional) Prefix that will be prepended to the VMs that you deploy"
  default     = ""
}



### VM Settings

variable "scsi_type" {
  type        = string
  description = "(Optional) SCSI Controller that will be used when creating the VM"
  validation {
    condition     = var.scsi_type != "pvscsi" || var.scsi_type != "lsilogic" || var.scsi_type != "lsilogic-sas"
    error_message = "The variable scsi_type must be \"pvscsi\", \"lsilogic\", or \"lsilogic-sas\"."
  }
  default = ""
}

variable "network_adapter_type" {
  type        = string
  description = "(Optional) Network adapter type  that will be used when creating the VM"
  validation {
    condition     = var.network_adapter_type != "vmxnet3" || var.network_adapter_type != "e1000" || var.network_adapter_type != "e1000e"
    error_message = "The variable network_adapter_type must be \"vmxnet3\", \"e1000\", or \"e1000e\"."
  }
  default = ""
}

variable "firmware" {
  type        = string
  description = "(Optional) Bios type that will be used when creating the VM"
  validation {
    condition     = var.firmware != "efi" || var.firmware != "bios"
    error_message = "The variable firmware must be \"efi\" or \"bios\"."
  }
  default = ""
}


### Conditionals
variable "linked_clone" {
  type        = bool
  description = "(Optional) Conditional that determines if a cloned VM will be deployed as a linked clone"
  default     = false
}

variable "datastore" {
  type        = bool
  description = "(Optional) Conditional that allows for the use of Datastores when deploying VMs"
  default     = true
}

variable "datastore_name" {
  description = "(Optional) Name of the datastore that will be used when deploying VMs. Required if var.datastore is set to true."
  type        = string
  default     = ""
}

variable "datastore_cluster" {
  type        = bool
  description = "(Optional) Conditional that allows for the use of Datastore Cluster when deploying VMs"
  default     = false
}

variable "datastore_cluster_name" {
  description = "(Optional) Name of the Datastore Cluster that will be used when deploying VMs. Required if var.datastore_cluster is set to true."
  type        = string
  default     = ""
}

variable "thin_provision" {
  type        = bool
  description = "(Optional) Conditional that determines if  the VM that will be created will be thin or thick provisioned"
  default     = true
}

variable "content_library" {
  type        = bool
  description = "(Optional) Conditional that allows for the use of a Content Library when deploying VMs"
  default     = false
}

variable "content_library_name" {
  type        = string
  description = "(Optional) Name of the Content Library that will be used when deploying VMs. Required if var.content_library is set to true."
  default     = ""
}

variable "content_library_template_type" {
  type        = string
  description = "(Optional) Type of template in the Content Library that will be used when deploying VMs. Required if var.content_library is set to true."
  validation {
    condition     = var.content_library_template_type != "vm-template" || var.content_library_template_type != "ovf"
    error_message = "The variable content_library_template_type must be \"vm-template\" or \"ovf\"."
  }
  default = ""
}

variable "tags" {
  type        = bool
  description = "(Optional) Conditional that allows for the setting of tags on a VM"
  default     = false
}

variable "template" {
  type        = bool
  description = "(Optional) Conditional that determines if a template will be used as the source for the VMs"
  default     = true
}

variable "template_name" {
  description = "(Optional) Name of the template that the VMs will be cloned from. Required if var.template is set to true"
  type        = string
  default     = ""
}