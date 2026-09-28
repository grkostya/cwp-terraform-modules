variable "name" {
  type        = string
  description = <<-EOT
    (Required) Specifies the name of the container registry.
    Only lowercase Alphanumeric characters allowed.
    Changing this forces a new resource to be created.
    This must be unique across the entire Azure service, not just within the resource group.
  EOT
}


variable "resource_group" {
  type = object({
    name     = string
    location = string
    tags     = map(string)
  })
  description = <<-EOT
    name     = (Required) The name of the resource group in which to create the container registry. Changing this forces a new resource to be created.
    location = (Required) The location/region where the container registry is created. Changing this forces a new resource to be created.
    tags     = (Optional) A mapping of tags to assign to the resource.
  EOT
  default     = null
}


variable "resource_group_name" {
  type        = string
  description = <<-EOT
    (Required) The name of the resource group in which to create the container registry.
    Changing this forces a new resource to be created.
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


variable "sku" {
  description = "Use to set a SKU for the container registry, by default the SKU will be Premium"
  type        = string
  default     = "Premium"
}


variable "admin_enabled" {
  type        = bool
  description = "(Optional) Specifies whether the admin user is enabled. Defaults to false."
  default     = false
}


variable "identity" {
  type = object({
    type         = optional(string)
    identity_ids = optional(set(string))
  })
  description = <<-EOT
    type         = (Required) Specifies the type of Managed Service Identity
                   that should be configured on this Container Registry.
                   Possible values are 'SystemAssigned', 'UserAssigned',
                   'SystemAssigned, UserAssigned' (to enable both).
    identity_ids = (Optional) Specifies a list of User Assigned Managed Identity IDs
                    to be assigned to this Container Registry.
                    This is required when type is set to 'UserAssigned' or 'SystemAssigned, UserAssigned'.
    NOTE:
    The assigned 'principal_id' and 'tenant_id' can be retrieved after the identity 'type'
    has been set to 'SystemAssigned' and Container Registry has been created.
  EOT
  default     = null
}


variable "customer_managed_key" {
  type = object({
    key_vault_key_id                 = string
    user_assigned_identity_id        = string
    user_assigned_identity_client_id = string
  })
  default = null
}


variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Whether public network access is allowed for the container registry."
  default     = false
}

variable "export_policy_enabled" {
  type        = bool
  description = "(Optional) Boolean value that indicates whether export policy is enabled. Defaults to false. In order to set it to true, make sure the public_network_access_enabled is also set to true."
  default     = false
}

variable "anonymous_pull_enabled" {
  type        = bool
  description = "(Optional) Whether allows anonymous (unauthenticated) pull access to this Container Registry."
  default     = false
}

variable "zone_redundancy_enabled" {
  type        = bool
  description = "(Optional) Whether zone redundancy is enabled for this Container Registry. Changing this forces a new resource to be created."
  default     = false
}

variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = null
}


variable "retention_policy_in_days" {
  type        = number
  description = <<-EOT
    (Optional) The number of days to retain an untagged manifest after which it gets purged.
    Defaults to 7. Ignored (set to null) when sku is 'Basic', as retention policies are not supported on the Basic tier.
  EOT
  default     = 7
}
