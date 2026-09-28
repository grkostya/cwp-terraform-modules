variable "resource_group_name" {
  type        = string
  description = <<-EOT
    (Required) The name of the resource group in which to create the resource.
    Changing this forces a new resource to be created.
  EOT
  default     = null
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
    tags     = map(string)
  })
  description = <<-EOT
    name     = (Required) The name of the resource group in which to create the resource. Changing this forces a new resource to be created.
    location = (Required) The location/region where the resource is created. Changing this forces a new resource to be created.
    tags     = (Optional) A mapping of tags to assign to the resource.
  EOT
  default     = null
}

variable "location" {
  type        = string
  description = <<-EOT
    (Required) Specifies the supported Azure location where the resource exists.
    Changing this forces a new resource to be created.
  EOT
  default     = null
}


variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = null
}


variable "name" {
  type        = string
  description = <<-EOT
     (Required) Specifies the name of the Recovery Services Vault.
     Recovery Service Vault name must be 2 - 50 characters long, start with a letter,
     contain only letters, numbers and hyphens. Changing this forces a new resource to be created.
  EOT
}


variable "sku" {
  type        = string
  description = "(Required) Sets the vault's SKU. Possible values include: 'Standard', 'RS0'."
  default     = "Standard"
}


variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Is it enabled to access the vault from public networks. Defaults to 'false'."
  default     = false
}


variable "storage_mode_type" {
  type        = string
  description = <<-EOT
    (Optional) The storage type of the Recovery Services Vault.
    Possible values are 'GeoRedundant', 'LocallyRedundant' and 'ZoneRedundant'. Defaults to 'GeoRedundant'.
  EOT
  default     = "GeoRedundant"
}


variable "cross_region_restore_enabled" {
  type        = string
  description = <<-EOT
    (Optional) Is cross region restore enabled for this Vault?
    Only can be 'true', when 'storage_mode_type' is 'GeoRedundant'. Defaults to 'false'.

    Note:
      Once 'cross_region_restore_enabled' is set to 'true', changing it back to 'false' forces
      a new Recovery Service Vault to be created.
  EOT
  default     = false
}


variable "soft_delete_enabled" {
  type        = bool
  description = "(Optional) Is soft delete enable for this Vault? Defaults to 'true'."
  default     = true
}


variable "immutability" {
  type        = string
  description = <<-EOT
    (Optional) Immutability Settings of vault, possible values include: 'Locked', 'Unlocked' and 'Disabled'.

    Note:
      Once 'immutability' is set to 'Locked', changing it to other values forces a new Recovery Services Vault to be created.
  EOT
  default     = "Disabled"
}


variable "identity" {
  type = object({
    type = optional(string)
    ids  = list(string)
  })
  description = <<-EOT
    type = (Required) Specifies the type of Managed Service Identity that should be configured on this Recovery Services Vault.
           Possible values are 'SystemAssigned', 'UserAssigned', 'SystemAssigned, UserAssigned' (to enable both).
    ids  = (Optional) A list of User Assigned Identity IDs to be associated with the Recovery Services Vault.
  EOT
  default = {
    ids = []
  }
}


variable "encryption" {
  type = object({
    infrastructure_encryption_enabled = optional(bool, true)
    key_id                            = string
    user_assigned_identity_id         = optional(string)
    # use_system_assigned_identity      = optional(bool) ## Defined in locals
  })
  description = <<-EOT
    infrastructure_encryption_enabled = (Required) Enabling/Disabling the Double Encryption state.
    key_id                            = (Required) The Key Vault key id used to encrypt this vault.
                                        Key managed by Vault Managed Hardware Security Module is also supported.
    user_assigned_identity_id         = (Optional) Specifies the user assigned identity ID to be used.
    use_system_assigned_identity      = (Optional) Indicate that system assigned identity should be used or not.
                                        Defaults to 'true'. Must be set to 'false' when 'user_assigned_identity_id' is set.
    Note:
      'use_system_assigned_identity' only be able to set to 'false' for new vaults.
      Any vaults containing existing items registered or attempted to be registered to it
      are not supported. Details can be found in the document (https://learn.microsoft.com/en-us/azure/backup/encryption-at-rest-with-cmk?tabs=portal#before-you-start)

    Note:
      Once 'infrastructure_encryption_enabled' has been set it's not possible to change it.
  EOT
  default = {
    key_id = null
  }
}


# variable "monitoring" {
#   type = object({
#     alerts_for_all_job_failures_enabled            = optional(bool, true)
#     alerts_for_critical_operation_failures_enabled = optional(bool, true)
#   })
#   description = <<-EOT
#     alerts_for_all_job_failures_enabled            = (Optional) Enabling/Disabling built-in Azure Monitor alerts
#                                                      for security scenarios and job failure scenarios. Defaults to 'true'.
#     alerts_for_critical_operation_failures_enabled = (Optional) Enabling/Disabling alerts from the older (classic alerts) solution.
#                                                      Defaults to 'true'. More details could be found here (https://learn.microsoft.com/en-us/azure/backup/monitoring-and-alerts-overview).
#   EOT
#   default = {
#     alerts_for_all_job_failures_enabled            = true
#     alerts_for_critical_operation_failures_enabled = true
#   }
# }
