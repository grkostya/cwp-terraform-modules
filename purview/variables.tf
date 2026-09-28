variable "resource_group" {
  type = object({
    name     = string
    location = string
    tags     = map(string)
  })
  description = <<-EOT
    name     = (Required) The name of the resource group in which to create the Purview Account. Changing this forces a new resource to be created.
    location = (Required) The location/region where Purview Account host is created. Changing this forces a new resource to be created.
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
  description = "(Required) The name of the resource group in which to create the Purview Account. Changing this forces a new resource to be created."
  default     = null
}


variable "location" {
  type        = string
  description = "(Required) The location/region where to create the Purview Account. Changing this forces a new resource to be created."
  default     = null
}


variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = null
}


variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Purview Account. Changing this forces a new resource to be created."
}


variable "user_assigned_identity_id" {
  type        = string
  description = "(Optional) The User Assigned Managed Identity ID to be assigned to this Purview Account."
  default     = null
}


variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Whether or not public network access is allowed for this Purview account. Defaults to 'false'."
  default     = false
}
