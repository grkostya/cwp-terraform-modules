variable "name" {
  type        = string
  description = <<-EOT
    (Required) Specifies the name of the log analytics workspace.
  EOT
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

variable "sku" {
  type        = string
  description = "(Optional) Specifies the SKU of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, and PerGB2018."
  default     = "PerGB2018"
}

variable "retention_in_days" {
  type        = number
  description = "(Optional) The workspace data retention in days. Possible values are either 7 (Free Tier only) or range between 30 and 730."
  default     = 30
}

variable "internet_ingestion_enabled" {
  type        = bool
  description = "(Optional) Should the Log Analytics Workspace support ingestion over the Public Internet?"
  default     = false
}

variable "internet_query_enabled" {
  type        = bool
  description = "(Optional) Should the Log Analytics Workspace support querying over the Public Internet?"
  default     = false
}

variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = null
}
