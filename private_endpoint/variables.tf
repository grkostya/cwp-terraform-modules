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


variable "name" {
  type        = string
  description = "(Required) The name of the Private Endpoint. Changing this forces a new resource to be created."
  default     = null
}


variable "private_connection_resource" {
  type = object({
    id   = string
    name = string
  })
  description = "The Private Link Enabled Remote Resource which this Private Endpoint should be connected to."
}


variable "subnet_id" {
  type        = string
  description = <<-EOT
    (Required) The ID of the Subnet from which Private IP Addresses will be allocated for
    this Private Endpoint. Changing this forces a new resource to be created.
  EOT
}


variable "private_dns_zone_ids" {
  type        = list(string)
  description = "(Required) Specifies the list of Private DNS Zones to include within the 'private_dns_zone_group'."
}


variable "subresource_names" {
  type        = list(string)
  description = <<-EOT
    (Optional) A list of subresource names which the Private Endpoint is able to connect to.
    'subresource_names' corresponds to 'group_id'.
    Possible values are detailed in the product documentation in the 'Subresources' column.
    Changing this forces a new resource to be created.
    NOTE:
        Some resource types (such as Storage Account) only support 1 subresource per private endpoint.
    NOTE 2:
        For most Private Links one or more subresource_names will need to be specified,
        please see the linked documentation for details.

  EOT
  default     = []
}
