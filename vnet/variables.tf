variable "vnet_name" {
  type        = string
  description = "(Required) The name of the virtual network. Changing this forces a new resource to be created."
}


variable "resource_group" {
  type = object({
    name     = string
    location = string
    tags     = map(string)
  })
  description = <<-EOT
    name     = (Required) The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created.
    location = (Required) The location/region where the virtual network is created. Changing this forces a new resource to be created.
    tags     = (Optional) A mapping of tags to assign to the resource.
  EOT
  default     = null
}


variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created."
  default     = null
}


variable "location" {
  type        = string
  description = "(Required) The location/region where the virtual network is created. Changing this forces a new resource to be created."
  default     = null
}


variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = null
}


variable "address_space" {
  type        = set(string)
  description = "The address space that is used the virtual network. You can supply more than one address space."
  default     = ["10.0.0.0/16"]
}


variable "default_subnet" {
  type = object({
    name              = optional(string, "default")
    address_prefixes  = optional(list(string), ["10.0.0.0/24"])
    security_group_id = optional(string)
    service_endpoints = optional(list(string))
  })
  description = <<-EOT
    name              = (Required) The name of the subnet.
    address_prefix    = (Required) The address prefix to use for the subnet.
    security_group_id = (Optional) The Network Security Group to associate with the subnet. (Referenced by 'id', ie.' azurerm_network_security_group.example.id')
    service_endpoints = (Optional) The list of Service endpoints to associate with the subnet.
                                   Possible values include:
                                   'Microsoft.AzureActiveDirectory',' Microsoft.AzureCosmosDB',
                                   'Microsoft.ContainerRegistry', 'Microsoft.EventHub', 'Microsoft.KeyVault',
                                   'Microsoft.ServiceBus', 'Microsoft.Sql', 'Microsoft.Storage', 'Microsoft.Storage.Global'
                                   and 'Microsoft.Web'.
  EOT
  default     = {}
}




#########################################################
### Network Security Group

variable "nsg_name" {
  type        = string
  description = "(Required) Specifies the name of the network security group. Changing this forces a new resource to be created."
  default     = null
}


variable "nsg_rules" {
  type = map(object({
    priority                                   = number
    direction                                  = string
    access                                     = string
    source_address_prefix                      = optional(string)
    source_address_prefixes                    = optional(list(string))
    source_port_range                          = optional(string)
    source_port_ranges                         = optional(list(string))
    source_application_security_group_ids      = optional(list(string))
    destination_address_prefix                 = optional(string)
    destination_address_prefixes               = optional(list(string))
    destination_application_security_group_ids = optional(list(string))
    destination_port_range                     = optional(string)
    destination_port_ranges                    = optional(list(string))
    protocol                                   = string
    description                                = optional(string)
  }))
  description = <<-EOT
    priority                                   = (Required) Specifies the priority of the rule. The value can be between '100' and '4096'. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
    direction                                  = (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are 'Inbound' and 'Outbound'.
    access                                     = (Required) Specifies whether network traffic is allowed or denied. Possible values are 'Allow' and 'Deny'.
    source_address_prefix                      = (Optional) CIDR or source IP range or * to match any IP. Tags such as 'VirtualNetwork', 'AzureLoadBalancer' and 'Internet' can also be used. This is required if 'source_address_prefixes' is not specified.
    source_address_prefixes                    = (Optional) List of source address prefixes. Tags may not be used. This is required if 'source_address_prefix' is not specified.
    source_port_range                          = (Optional) Source Port or Range. Integer or range between '0' and '65535' or '*' to match any. This is required if 'source_port_ranges' is not specified.
    source_port_ranges                         = (Optional) List of source ports or port ranges. This is required if 'source_port_range' is not specified.
    source_application_security_group_ids      = (Optional) A List of source Application Security Group IDs.
    destination_address_prefix                 = (Optional) CIDR or destination IP range or * to match any IP. Tags such as 'VirtualNetwork', 'AzureLoadBalancer' and 'Internet' can also be used. This is required if 'destination_address_prefixes' is not specified.
    destination_address_prefixes               = (Optional) List of destination address prefixes. Tags may not be used. This is required if 'destination_address_prefix' is not specified.
    destination_application_security_group_ids = (Optional) A List of destination Application Security Group IDs.
    destination_port_range                     = (Optional) Destination Port or Range. Integer or range between '0' and '65535' or '*' to match any. This is required if 'destination_port_ranges' is not specified.
    destination_port_ranges                    = (Optional) List of destination ports or port ranges. This is required if 'destination_port_range' is not specified.
    protocol                                   = (Required) Network protocol this rule applies to. Possible values include 'Tcp', 'Udp', 'Icmp', 'Esp', 'Ah' or '*' (which matches all)
    description                                = (Optional) A description for this rule. Restricted to 140 characters.
  EOT
  default     = {}
}
