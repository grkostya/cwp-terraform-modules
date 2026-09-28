variable "fabric_capacity_name" {
  description = "Name of the solution"
  type        = string
  sensitive   = false
  nullable    = false
}

variable "fabric_capacity_sku" {
  description = "Fabric Capacity SKU name"
  type        = string
  sensitive   = false
  nullable    = false
  default     = "F2"

  validation {
    condition     = contains(["F2", "F4", "F8", "F16", "F32", "F64", "F128", "F256", "F512", "F1024", "F2048"], var.fabric_capacity_sku)
    error_message = "Please specify a valid Fabric Capacity SKU. Valid values are: [ 'F2', 'F4', 'F8', 'F16', 'F32', 'F64', 'F128', 'F256', 'F512', 'F1024', 'F2048' ]."
  }
}

# An array of administrator user identities. The member must be an Entra member user or a service principal.
variable "fabric_capacity_admin_upns" {
  description = "Collection of admin UPNs for the Fabric Capacity."
  type        = set(string)
  sensitive   = false
  nullable    = false
  default     = []
}

variable "resource_group_name" {
  description = "Name of the Resource Group, this is precreated resource group"
  type        = string
}

variable "location" {
  description = "Location of the Azure resources"
  type        = string
  default     = "uaenorth"
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
