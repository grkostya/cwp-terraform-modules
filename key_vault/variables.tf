variable "name" {
  type        = string
  description = <<-EOT
    (Required) Specifies the name of the Key Vault. Changing this forces a new resource to be created.
    The name must be globally unique. If the vault is in a recoverable state then
    the vault will need to be purged before reusing the name.
  EOT
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

  validation {
    condition     = var.resource_group != null || (var.resource_group_name != null && var.location != null)
    error_message = <<-EOT
      Input is required:
      Provide either the 'resource_group' object or the values for 'resource_group_name' and 'location'
    EOT
  }
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


variable "tenant_id" {
  type        = string
  description = "(Required) The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault."
  default     = null
}


variable "purge_protection_enabled" {
  type        = bool
  description = "(Optional) Is Purge Protection enabled for this Key Vault?"
  default     = true
}


variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Whether public network access is allowed for this Key Vault. Defaults to 'false'."
  default     = false
}


variable "network_acls" {
  type = object({
    bypass                     = optional(string, "AzureServices")
    default_action             = optional(string, "Deny")
    ip_rules                   = optional(list(string), [])
    virtual_network_subnet_ids = optional(list(string), [])
  })
  description = <<-EOT
    bypass                     = (Optional) Specifies which traffic can bypass the network rules. Possible values are 'AzureServices' and 'None'. Defaults to 'AzureServices'.
    default_action             = (Optional) The default action when no rules match. Possible values are 'Allow' and 'Deny'. Defaults to 'Deny'.
    ip_rules                   = (Optional) One or more IP Addresses or CIDR Blocks which should be able to access the Key Vault.
    virtual_network_subnet_ids = (Optional) One or more Subnet IDs which should be able to access the Key Vault.
  EOT
  default     = {}
}
