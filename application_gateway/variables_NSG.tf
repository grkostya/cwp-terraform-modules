variable "NSG" {
  type = object({
    name                = string
    resource_group_name = string
    id                  = string
  })
  description = <<-EOT
      name                = (Required) The name of the Network Security Group.
      resource_group_name = (Required) The name of the resource group in which to create the Network Security Group.
      id                  = The ID of the Network Security Group.
    EOT
  default     = null

  validation {
    condition     = var.create_NSG_rules == true ? var.NSG != null : true
    error_message = <<-EOT
      Input is required:
      Provide the 'NSG' object when 'create_NSG_rules' is set to 'true'.
    EOT
  }
}


variable "create_NSG_rules" {
  type        = bool
  description = "(Optional) Whether to create Network Security Group rules for the Application Gateway. Default: 'false'."
  default     = false
}


variable "NSG_allowed_sources" {
  type        = list(string)
  description = "(Optional) List of source IP addresses or IP ranges to allow traffic from."
  default     = null
}
