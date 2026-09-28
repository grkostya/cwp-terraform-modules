variable "name" {
  type        = string
  description = "(Required) Specifies the name of the App Service Plan. Changing this forces a new resource to be created."
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


variable "sku_name" {
  type        = string
  description = "(Required) The SKU for the plan. Examples: B1, B2, B3, P1v2, P2v2, S1."
}


variable "os_type" {
  type        = string
  description = "(Optional) The O/S type for the App Services hosted in this plan. Defaults to 'Linux'."
  default     = "Linux"
}
