variable "name" {
  description = "The name of the Azure Maps account."
  type        = string
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
    tags     = map(string)
  })
  description = <<-EOT
    name     = (Required) The name of the resource group in which to create the CosmosDB Account. Changing this forces a new resource to be created.
    location = (Required) The location/region where CosmosDB Account host is created. Changing this forces a new resource to be created.
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
  description = "The name of the resource group."
  type        = string
  default     = null
}

variable "location" {
  description = "The Azure location for the Maps account."
  type        = string
  default     = "westeurope"
}

variable "sku_name" {
  description = "(Required) The SKU of the Azure Maps Account."
  type        = string
  default     = "G2"
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

# CORS block (Optional)
variable "cors" {
  description = <<EOT
(Optional) A list of CORS rules for the Maps Account.
Example:
[
  {
    allowed_origins = ["https://example.com"]
  }
]
EOT
  type = list(object({
    allowed_origins = list(string)
  }))
  default = []
}

# DATA_STORE block (Optional)
variable "data_store" {
  description = <<EOT
(Optional) List of data_store blocks.
Example:
[
  {
    storage_account_id = "..."
    unique_name        = "somename"
  }
]
EOT
  type = list(object({
    storage_account_id = string
    unique_name        = string
  }))
  default = []
}

# IDENTITY block (Optional)
variable "identity" {
  description = <<EOT
(Optional) Managed Service Identity configuration.
Example:
{
  type         = "SystemAssigned"
  identity_ids = ["id1", "id2"] # Optional
}
EOT
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

# LOCAL AUTHENTICATION ENABLED (Optional)
variable "local_authentication_enabled" {
  description = "(Optional) Is local authentication enabled for this Azure Maps Account? When false, disables all local keys except AAD. Defaults to true."
  type        = bool
  default     = true
}
