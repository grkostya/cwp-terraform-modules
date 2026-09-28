variable "name" {
  type        = string
  description = "(Required) Specifies the name of the bastion host. Changing this forces a new resource to be created."
}


variable "resource_group" {
  type = object({
    name     = string
    location = string
    tags     = map(string)
  })
  description = <<-EOT
    name     = (Required) The name of the resource group in which to create the bastion host. Changing this forces a new resource to be created.
    location = (Required) The location/region where the bastion host is created. Changing this forces a new resource to be created.
    tags     = (Optional) A mapping of tags to assign to the resource.
  EOT
  default     = null
}


variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the bastion host. Changing this forces a new resource to be created."
  default     = null
}


variable "location" {
  type        = string
  description = "(Required) The location/region where the bastion host is created. Changing this forces a new resource to be created."
  default     = null
}


variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = null
}


# variable "subnet_id" {
#   type        = string
#   description = "The ID of the Subnet where this Network Interface should be located in."
# }

variable "sku" {
  type        = string
  description = "(Optional) The SKU of the Bastion Host. Accepted values are 'Developer', 'Basic' and 'Standard'. Defaults to 'Standard'."
  default     = "Standard"
}


variable "virtual_network_name" {
  type        = string
  description = "(Required) The name of the virtual network to which to attach the subnet for bastion host. Changing this forces a new resource to be created."
}


variable "subnet_address_prefixes" {
  type        = set(string)
  description = "(Required) The address prefixes to use for the subnet for bastion host."
}


variable "tunneling_enabled" {
  type        = bool
  description = "(Optional) Is Tunneling feature enabled for the Bastion Host. Defaults to false."
  default     = false
}
