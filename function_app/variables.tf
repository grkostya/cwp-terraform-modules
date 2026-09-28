variable "location" {
  description = "Location of the Azure resources"
  type        = string
  sensitive   = false
  nullable    = false
  default     = "uaenorth"
}

variable "resource_group_name" {
  description = "Name of the Resource Group, this is precreated resource group"
  type        = string
  sensitive   = false
  nullable    = false
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

variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = null
}

variable "function_app_name" {
  description = "Name of the Function App"
  type        = string
  default     = "DS-DEV-OsduRouter-AzureFunction"
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  description = <<-EOT
      type         = (Required) Specifies the type of Managed Service Identity that should be
                     configured on this Function App.
                     Possible values are 'SystemAssigned' or 'UserAssigned'.
      identity_ids = (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to
                     this Function App. This is required when type is set to 'UserAssigned'.
                     Currently only one User Assigned Identity is supported.
            NOTE:
                  type = "UserAssigned" ## To use wiht an existing private DNS zone
                  identity_ids = [azurerm_user_assigned_identity.*.id]
    EOT
  default = {
    type         = "SystemAssigned"
    identity_ids = []
  }
}

variable "create_service_plan" {
  description = "Whether the module should create a new App Service Plan."
  type        = bool
  default     = true
}

variable "existing_app_service_plan_id" {
  description = "ID of an existing App Service Plan. If provided, a new plan will not be created."
  type        = string
  default     = null
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan when a new plan is created. Must be provided if no existing plan is used."
  type        = string
  default     = ""
  validation {
    condition     = var.existing_app_service_plan_id != "" || var.app_service_plan_name != ""
    error_message = "Either an existing_app_service_plan_id or an app_service_plan_name must be provided."
  }
}

variable "service_plan_os_type" {
  description = "Operating system type for the App Service Plan (Linux or Windows)."
  type        = string
  default     = "Linux"
}

variable "service_plan_sku" {
  description = "Service Plan SKU"
  type        = string
  default     = "P2v3"
}

variable "swift_subnet_id" {
  description = "Function Swift Subnet ID"
  type        = string
}

variable "law_id" {
  type        = string
  description = <<-EOT
   (Required)  Specifies the id of a log analytics workspace resource.
  EOT
}

# variable "ase_name" {
#   description = "App Service Environment name"
#   type        = string
#   default     = ""
# }

# variable "app_service_environment_id" {
#   description = "Existing App Service Environment ID"
#   type        = string
#   default     = ""
# }

variable "function_storage_account_name" {
  description = "Storage Account name"
  type        = string
}

variable "app_insights_name" {
  description = "Name to create the Application Insights resource. If provided, external values must not be provided."
  type        = string
  default     = ""
  validation {
    condition     = var.app_insights_name == "" || (var.application_insights_external.connection_string == "" && var.application_insights_external.instrumentation_key == "")
    error_message = "If app_insights_name is provided, external values (connection_string and instrumentation_key) must not be provided."
  }
}

variable "application_insights_external" {
  type = object({
    connection_string   = string
    instrumentation_key = string
  })
  default = {
    connection_string   = ""
    instrumentation_key = ""
  }
}

variable "cors_allowed_origins" {
  type    = list(string)
  default = []
}

variable "cors_support_credentials" {
  type    = bool
  default = false
}
