variable "application_insights_id" {
  type        = string
  description = <<-EOT
    (Required) The ID of the Application Insights associated with this Machine Learning Workspace.
  EOT
}

variable "name" {
  type        = string
  description = <<-EOT
    (Required) Specifies the name of the ML workspace.
  EOT
}


variable "storage_account_id" {
  type        = string
  description = <<-EOT
    (Required) The storage account ID for the ML workspace.
  EOT
}


variable "container_registry_id" {
  type        = string
  description = <<-EOT
    (Required) The container registry ID for the ML workspace.
  EOT
}

variable "key_vault_id" {
  type        = string
  description = <<-EOT
    (Required) The keyvault ID for the ML workspace.
  EOT
}

variable "serverless_compute_subnet_id" {
  type        = string
  description = <<-EOT
    (Required) The subnet ID for the ML workspace serverless compute. Can be the same as for ML workspaces
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


variable "identity" {
  type = object({
    type         = optional(string)
    identity_ids = optional(set(string))
  })
  description = <<-EOT
    type         = (Required) Specifies the type of Managed Service Identity
                   that should be configured on this ML workspace.
                   Possible values are 'SystemAssigned', 'UserAssigned',
                   'SystemAssigned, UserAssigned' (to enable both).
    identity_ids = (Optional) Specifies a list of User Assigned Managed Identity IDs
                    to be assigned to this Storage Account.
                    This is required when type is set to 'UserAssigned' or 'SystemAssigned, UserAssigned'.
    NOTE:
    The assigned 'principal_id' and 'tenant_id' can be retrieved after the identity 'type'
    has been set to 'SystemAssigned' and ML workspace has been created.
  EOT
  default     = null
}


variable "customer_managed_key" {
  type = object({
    key_vault_id              = string
    key_vault_key_id          = string
    user_assigned_identity_id = string
  })
  default = null
}


variable "high_business_impact" {
  type        = string
  description = <<-EOT
    Flag to signal High Business Impact (HBI) data in the workspace and reduce diagnostic data collected by the service.
    More info, can be found here: https://learn.microsoft.com/en-us/azure/machine-learning/concept-data-encryption?view=azureml-api-2#encryption-at-rest
    NOTE:
    Changing this flag forces a new resource to be created.
  EOT
  default     = true
}


variable "legacy_mode_enabled" {
  type        = bool
  description = <<-EOT
    Enable V1 API features, enabling this mode may prevent you from using features provided by the v2 API.
  EOT
  default     = false
}


variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = null
}


variable "image_build_compute_name" {
  type        = string
  description = "(Optional) The compute name for image build of the Machine Learning Workspace."
  default     = null
}


variable "public_network_access_enabled" {
  type        = bool
  description = <<-EOT
    (Optional) Enable public network access to the Machine Learning Workspace.
    When enabled, combine with allowed_ip_addresses to restrict access to specific IP ranges
    via the associated resources (storage account network rules, key vault network ACLs, NSGs).
  EOT
  default     = false
}
