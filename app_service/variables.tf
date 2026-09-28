variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Linux Web App. Changing this forces a new resource to be created."
}


variable "resource_group" {
  type = object({
    name     = string
    location = string
    tags     = map(string)
  })
  description = <<-EOT
    name     = (Required) The name of the resource group. Changing this forces a new resource to be created.
    location = (Required) The location/region. Changing this forces a new resource to be created.
    tags     = (Optional) Tags to inherit.
  EOT
  default     = null

  validation {
    condition     = var.resource_group != null || (var.resource_group_name != null && var.location != null)
    error_message = "Provide either 'resource_group' or 'resource_group_name' + 'location'."
  }
}


variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group. Changing this forces a new resource to be created."
  default     = null
}


variable "location" {
  type        = string
  description = "(Required) The Azure region."
  default     = null
}


variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = null
}


variable "service_plan_id" {
  type        = string
  description = "(Required) The ID of the App Service Plan within which to create this Linux Web App."
}


variable "node_version" {
  type        = string
  description = "(Required) The Node.js version to use in the application stack. Example: '20-lts'."
}


variable "app_settings" {
  type        = map(string)
  description = "(Optional) A map of key-value pairs of App Settings."
  default     = {}
}


variable "identity" {
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  description = <<-EOT
    type         = (Required) Specifies the type of Managed Service Identity. Possible values: 'SystemAssigned', 'UserAssigned'.
    identity_ids = (Optional) A list of User Assigned Managed Identity IDs. Required when type is 'UserAssigned'.
  EOT
  default = {
    type         = "SystemAssigned"
    identity_ids = []
  }
}


variable "auth_settings_v2" {
  type = object({
    require_authentication = optional(bool, true)
    unauthenticated_action = optional(string, "RedirectToLoginPage")
    default_provider       = optional(string, "azureactivedirectory")

    active_directory_v2 = optional(object({
      client_id                       = string
      tenant_auth_endpoint            = string
      client_secret_setting_name      = optional(string)
      allowed_audiences               = optional(list(string), [])
      jwt_allowed_groups              = optional(list(string), [])
      jwt_allowed_client_applications = optional(list(string), [])
    }))

    login = optional(object({
      token_store_enabled               = optional(bool, false)
      token_refresh_extension_time      = optional(number, 72)
      preserve_url_fragments_for_logins = optional(bool, false)
      cookie_expiration_convention      = optional(string, "FixedTime")
      cookie_expiration_time            = optional(string, "08:00:00")
      validate_nonce                    = optional(bool, true)
      nonce_expiration_time             = optional(string, "00:05:00")
    }), {})
  })
  description = <<-EOT
    (Optional) Authentication settings v2 (Easy Auth) for the Linux Web App. Set to null to disable.
    require_authentication = (Optional) Whether unauthenticated requests are blocked. Defaults to true.
    unauthenticated_action = (Optional) Action for unauthenticated requests. One of: 'AllowAnonymous', 'RedirectToLoginPage', 'Return401', 'Return403'. Defaults to 'RedirectToLoginPage'.
    default_provider       = (Optional) The default identity provider. Defaults to 'azureactivedirectory'.
    active_directory_v2    = (Optional) Azure Active Directory (Entra ID) provider settings.
    login                  = (Optional) Login flow settings. Sensible defaults applied when omitted.
  EOT
  default     = null
}
