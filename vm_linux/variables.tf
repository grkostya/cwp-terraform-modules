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
  description = <<-DESCRIPTION
    name     = (Required) The name of the resource group in which to create the virtual machine. Changing this forces a new resource to be created.
    location = (Required) The location/region where the virtual machine is created. Changing this forces a new resource to be created.
    tags     = (Optional) A mapping of tags to assign to the resource.
  DESCRIPTION
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
  description = "(Required) Specifies the size of the Virtual Machine."
  default     = "Standard_B2ats_v2"
}


variable "admin_username" {
  type        = string
  description = "(Required) Specifies the name of the local administrator account."
  default     = "azureuser"
}


variable "ssh_keys" {
  type        = string
  description = <<-DESCRIPTION
    (Required) The Public SSH Key.
    Example:
      ssh_keys = file("~/.ssh/id_rsa.pub")
  DESCRIPTION
}


variable "custom_data" {
  type        = string
  description = <<-DESCRIPTION
    (Optional) Specifies custom data to supply to the machine.
    On Linux-based systems, this can be used as a cloud-init script.
    On other systems, this will be copied as a file on disk.
    Internally, Terraform will base64 encode this value before sending it to the API.
    The maximum length of the binary array is 65535 bytes.
    Changing this forces a new resource to be created.
  DESCRIPTION
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
  description = <<-DESCRIPTION
    publisher = (Required) Specifies the publisher of the image used to create the virtual machines.
    offer     = (Required) Specifies the offer of the image used to create the virtual machines.
    sku       = (Required) Specifies the SKU of the image used to create the virtual machines.
    version   = (Required) Specifies the version of the image used to create the virtual machines.

    Changing this forces a new resource to be created.
  DESCRIPTION
  default = {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts" # "0001-com-ubuntu-server-jammy"
    sku       = "server"           # "22_04-lts-gen2"
    version   = "latest"
  }
}


variable "secure_boot_enabled" {
  type        = bool
  description = "(Optional) Specifies whether secure boot should be enabled on the virtual machine. Changing this forces a new resource to be created."
  default     = false
}


variable "encryption_at_host_enabled" {
  type        = bool
  description = <<-DESCRIPTION
    (Optional) Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted
    by enabling Encryption at Host?
    NOTE:
    'encryption_at_host_enabled' cannot be set to 'true' when 'security_encryption_type' is set to 'DiskWithVMGuestState'.
  DESCRIPTION
  default     = true
}


variable "patch_assessment_mode" {
  type        = string
  description = <<-DESCRIPTION
    (Optional) Specifies the mode of VM Guest Patching for the Virtual Machine.
    Possible values are 'AutomaticByPlatform' or 'ImageDefault'.
    Defaults to 'AutomaticByPlatform'.
    NOTE:
    If the patch_assessment_mode is set to 'AutomaticByPlatform' then
    the 'provision_vm_agent' field must be set to 'true'.
  DESCRIPTION
  default     = "AutomaticByPlatform"
}


variable "patch_mode" {
  type        = string
  description = <<-DESCRIPTION
    (Optional) Specifies the mode of in-guest patching to this Linux Virtual Machine.
    Possible values are 'AutomaticByPlatform' and 'ImageDefault'.
    Defaults to 'AutomaticByPlatform'. For more information on patch modes please see the product documentation.
    NOTE:
    If 'patch_mode' is set to 'AutomaticByPlatform' then 'provision_vm_agent' must also be set to 'true'.
  DESCRIPTION
  default     = "AutomaticByPlatform"
}


variable "bypass_platform_safety_checks_on_user_schedule_enabled" {
  type        = bool
  description = <<-DESCRIPTION
    (Optional) Specifies whether to skip platform scheduled patching when a user schedule
    is associated with the VM. Defaults to 'false'.

    Note:
        'bypass_platform_safety_checks_on_user_schedule_enabled' can only be set to
        'true' when 'patch_mode' is set to 'AutomaticByPlatform'.
  DESCRIPTION
  default     = false
}


variable "public_ip_address_id" {
  type        = string
  description = "(Optional) Reference to a Public IP Address to associate with this NIC"
  default     = null
}


variable "identity" {
  type = object({
    type         = string
    identity_ids = list(string)
  })
  description = <<-DESCRIPTION
    type         = (Required) Specifies the type of Managed Service Identity that
                    should be configured on this Linux Virtual Machine.
                    Possible values are 'SystemAssigned', 'UserAssigned',
                    'SystemAssigned, UserAssigned' (to enable both)
    identity_ids = (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned
                    to this Linux Virtual Machine.
  DESCRIPTION
  default = {
    type         = "SystemAssigned"
    identity_ids = null
  }
}
