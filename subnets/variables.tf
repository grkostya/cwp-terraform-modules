variable "subnet_name" {
  type        = string
  description = <<-EOT
    (Required) Specifies the name of the subnet.
  EOT

}

variable "nsg_resource_group" {
  type = object({
    name     = string
    location = string
    tags     = map(string)
  })
  description = <<-EOT
    name     = (Required) The name of the resource group in which to create the NSG.
    location = (Required) The location/region where the NSG resource group is created.
    tags     = (Optional) A mapping of tags assigned to the resource.
  EOT
  default     = null
}


variable "vnet" {
  type = object({
    name                = string
    resource_group_name = string
    location            = string
    tags                = map(string)
  })
  description = <<-EOT
    The `vnet` variable is an object that defines the details of the virtual network.

    - `name`                = The name of the virtual network.
    - `resource_group_name` = The name of the resource group where the virtual network is deployed.
    - `location`            = The Azure region where the virtual network is created.
    - `tags`                = A map of tags assigned to the virtual network.
  EOT
}


variable "address_prefixes" {
  type        = list(string)
  description = <<-EOT
      A list of CIDR blocks representing the address space for the subnet(s).
      Each entry in the list defines a subnet range within the virtual network.
      Example: ["10.0.1.0/24", "10.0.2.0/24"]
  EOT
}


variable "service_endpoints" {
  type        = list(string)
  description = <<-EOT
    A list of service endpoints to associate with the subnet.
    These endpoints allow private access to Azure services without traversing the public internet.
  E xample values: ["Microsoft.Storage", "Microsoft.Sql", "Microsoft.KeyVault"]
  EOT
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


variable "delegation" {
  type = object({
    name = string
    service_delegation = object({
      name    = string
      actions = optional(list(string), [])
    })
  })
  description = <<-EOT
  Specifies the delegation settings for the subnet. This allows a subnet to be explicitly delegated to a specific Azure service.
  - `name`: The name of the delegation.
  - `service_delegation`: An object that defines the service delegation.
  - `name`: The name of the Azure service to which the subnet is delegated.
  - `actions`: (Optional) A list of actions that define the permissions granted to the service.
  Example:
  delegation = { name = "example-delegation" service_delegation = { name = "Microsoft.Web/serverFarms" actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"] } }
  EOT
}


variable "route_table_id" {
  type        = string
  description = <<-EOT
  The ID of the route table to associate with the subnet.
  This ensures that the subnet follows specific routing rules
  defined in the provided route table.
  EOT
  default     = null
}


variable "use_udr" {
  type        = bool
  description = "Whether to associate a user-defined route table with the subnet?"
  default     = true
}


variable "additional_tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
  A map of additional tags to apply to all resources created by this module.
  These tags will be merged with the default tags provided by the module.
  Example:
    additional_tags = {
    "Environment" = "Production"
    "Owner"       = "DevOps Team"
  }
  EOT
}
