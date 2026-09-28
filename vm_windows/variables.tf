variable "vm_name" {
  type        = string
  description = "(Required) Specifies the name of the virtual machine. Changing this forces a new resource to be created."
}


variable "resource_group" {
  type = object({
    name     = string
    location = string
    tags     = map(string)
  })
  description = <<-EOT
    name     = (Required) The name of the resource group in which to create the virtual machine. Changing this forces a new resource to be created.
    location = (Required) The location/region where the virtual machine is created. Changing this forces a new resource to be created.
    tags     = (Optional) A mapping of tags to assign to the resource.
  EOT
  default     = null
}


variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the virtual machine. Changing this forces a new resource to be created."
  default     = null
}


variable "location" {
  type        = string
  description = "(Required) The location/region where the virtual machine is created. Changing this forces a new resource to be created."
  default     = null
}


variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = null
}


variable "subnet_id" {
  type        = string
  description = "The ID of the Subnet where this Network Interface should be located in."
}

variable "vm_size" {
  type        = string
  description = "(Required) The SKU which should be used for this Virtual Machine"
  default     = "Standard_B2ats_v2"
}


variable "admin_username" {
  type        = string
  description = "(Required) The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."
  default     = "azureuser"
}

variable "admin_password" {
  type        = string
  description = "(Required) The Password which should be used for the local-administrator on this Virtual Machine. Changing this forces a new resource to be created."
}


variable "custom_data" {
  type        = string
  description = <<-EOT
    (Optional) The Base64-Encoded Custom Data which should be used for this Virtual Machine.
    Changing this forces a new resource to be created.
  EOT
  default     = null
}


variable "disk_encryption_set_id" {
  type        = string
  description = "(Optional) The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk. Conflicts with 'secure_vm_disk_encryption_set_id'."
  default     = null
}

variable "os_disk_size_gb" {
  type        = number
  description = "(Optional) The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from."
  default     = null
}


variable "os_image" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = <<-EOT
    publisher = (Required) Specifies the publisher of the image used to create the virtual machines.
    offer     = (Required) Specifies the offer of the image used to create the virtual machines.
    sku       = (Required) Specifies the SKU of the image used to create the virtual machines.
    version   = (Required) Specifies the version of the image used to create the virtual machines.

    Changing this forces a new resource to be created.
  EOT
  default = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2025-datacenter-azure-edition"
    version   = "latest"
  }
}


variable "secure_boot_enabled" {
  type        = bool
  description = "(Optional) Specifies if Secure Boot and Trusted Launch is enabled for the Virtual Machine. Changing this forces a new resource to be created."
  default     = false
}


variable "encryption_at_host_enabled" {
  type        = bool
  description = <<-EOT
    (Optional) Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted
    by enabling Encryption at Host?
    NOTE:
    'encryption_at_host_enabled' cannot be set to 'true' when 'security_encryption_type' is set to 'DiskWithVMGuestState'.
  EOT
  default     = true
}


variable "patch_assessment_mode" {
  type        = string
  description = <<-EOT
    (Optional) Specifies the mode of VM Guest Patching for the Virtual Machine.
    Possible values are 'AutomaticByPlatform' or 'ImageDefault'.
    Defaults to 'ImageDefault'.
    NOTE:
    If the patch_assessment_mode is set to 'AutomaticByPlatform' then
    the 'provision_vm_agent' field must be set to 'true'.
  EOT
  default     = "ImageDefault"
}


variable "patch_mode" {
  type        = string
  description = <<-EOT
    (Optional) Specifies the mode of in-guest patching to this Windows Virtual Machine.
    Possible values are 'Manual', 'AutomaticByOS' and 'AutomaticByPlatform'. Defaults to 'AutomaticByOS'.
    For more information on patch modes please see the product documentation.
    NOTE:
    If 'patch_mode' is set to 'AutomaticByPlatform' then 'provision_vm_agent' must also be set to 'true'.
    If the Virtual Machine is using a hotpatching enabled image the 'patch_mode' must always be set to 'AutomaticByPlatform'.
  EOT
  default     = "AutomaticByOS"
}


variable "public_ip_address_id" {
  type        = string
  description = "(Optional) Reference to a Public IP Address to associate with NIC"
  default     = null
}


variable "computer_name" {
  type        = string
  description = <<-EOT
    (Optional) Specifies the Hostname which should be used for this Virtual Machine.
    If unspecified this defaults to the value for the 'name' field.
    If the value of the 'name' field is not a valid 'computer_name', then you must specify 'computer_name'.
    Changing this forces a new resource to be created.
  EOT
  default     = null
}
