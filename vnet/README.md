<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.95.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.95.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_subnet.default](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.Default](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | The address space that is used the virtual network. You can supply more than one address space. | `set(string)` | <pre>[<br/>  "10.0.0.0/16"<br/>]</pre> | no |
| <a name="input_default_subnet"></a> [default\_subnet](#input\_default\_subnet) | name              = (Required) The name of the subnet.<br/>address\_prefix    = (Required) The address prefix to use for the subnet.<br/>security\_group\_id = (Optional) The Network Security Group to associate with the subnet. (Referenced by 'id', ie.' azurerm\_network\_security\_group.example.id')<br/>service\_endpoints = (Optional) The list of Service endpoints to associate with the subnet.<br/>                               Possible values include:<br/>                               'Microsoft.AzureActiveDirectory',' Microsoft.AzureCosmosDB',<br/>                               'Microsoft.ContainerRegistry', 'Microsoft.EventHub', 'Microsoft.KeyVault',<br/>                               'Microsoft.ServiceBus', 'Microsoft.Sql', 'Microsoft.Storage', 'Microsoft.Storage.Global'<br/>                               and 'Microsoft.Web'. | <pre>object({<br/>    name              = optional(string, "default")<br/>    address_prefixes  = optional(list(string), ["10.0.0.0/24"])<br/>    security_group_id = optional(string)<br/>    service_endpoints = optional(list(string))<br/>  })</pre> | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The location/region where the virtual network is created. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_nsg_name"></a> [nsg\_name](#input\_nsg\_name) | (Required) Specifies the name of the network security group. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_nsg_rules"></a> [nsg\_rules](#input\_nsg\_rules) | priority                                   = (Required) Specifies the priority of the rule. The value can be between '100' and '4096'. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.<br/>direction                                  = (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are 'Inbound' and 'Outbound'.<br/>access                                     = (Required) Specifies whether network traffic is allowed or denied. Possible values are 'Allow' and 'Deny'.<br/>source\_address\_prefix                      = (Optional) CIDR or source IP range or * to match any IP. Tags such as 'VirtualNetwork', 'AzureLoadBalancer' and 'Internet' can also be used. This is required if 'source\_address\_prefixes' is not specified.<br/>source\_address\_prefixes                    = (Optional) List of source address prefixes. Tags may not be used. This is required if 'source\_address\_prefix' is not specified.<br/>source\_port\_range                          = (Optional) Source Port or Range. Integer or range between '0' and '65535' or '*' to match any. This is required if 'source\_port\_ranges' is not specified.<br/>source\_port\_ranges                         = (Optional) List of source ports or port ranges. This is required if 'source\_port\_range' is not specified.<br/>source\_application\_security\_group\_ids      = (Optional) A List of source Application Security Group IDs.<br/>destination\_address\_prefix                 = (Optional) CIDR or destination IP range or * to match any IP. Tags such as 'VirtualNetwork', 'AzureLoadBalancer' and 'Internet' can also be used. This is required if 'destination\_address\_prefixes' is not specified.<br/>destination\_address\_prefixes               = (Optional) List of destination address prefixes. Tags may not be used. This is required if 'destination\_address\_prefix' is not specified.<br/>destination\_application\_security\_group\_ids = (Optional) A List of destination Application Security Group IDs.<br/>destination\_port\_range                     = (Optional) Destination Port or Range. Integer or range between '0' and '65535' or '*' to match any. This is required if 'destination\_port\_ranges' is not specified.<br/>destination\_port\_ranges                    = (Optional) List of destination ports or port ranges. This is required if 'destination\_port\_range' is not specified.<br/>protocol                                   = (Required) Network protocol this rule applies to. Possible values include 'Tcp', 'Udp', 'Icmp', 'Esp', 'Ah' or '*' (which matches all)<br/>description                                = (Optional) A description for this rule. Restricted to 140 characters. | <pre>map(object({<br/>    priority                                   = number<br/>    direction                                  = string<br/>    access                                     = string<br/>    source_address_prefix                      = optional(string)<br/>    source_address_prefixes                    = optional(list(string))<br/>    source_port_range                          = optional(string)<br/>    source_port_ranges                         = optional(list(string))<br/>    source_application_security_group_ids      = optional(list(string))<br/>    destination_address_prefix                 = optional(string)<br/>    destination_address_prefixes               = optional(list(string))<br/>    destination_application_security_group_ids = optional(list(string))<br/>    destination_port_range                     = optional(string)<br/>    destination_port_ranges                    = optional(list(string))<br/>    protocol                                   = string<br/>    description                                = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | name     = (Required) The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created.<br/>location = (Required) The location/region where the virtual network is created. Changing this forces a new resource to be created.<br/>tags     = (Optional) A mapping of tags to assign to the resource. | <pre>object({<br/>    name     = string<br/>    location = string<br/>    tags     = map(string)<br/>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(any)` | `null` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | (Required) The name of the virtual network. Changing this forces a new resource to be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Virtual Network resource id |
| <a name="output_nsg_id"></a> [nsg\_id](#output\_nsg\_id) | n/a |
| <a name="output_nsg_name"></a> [nsg\_name](#output\_nsg\_name) | n/a |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | n/a |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | n/a |
| <a name="output_vnet_resource_group_name"></a> [vnet\_resource\_group\_name](#output\_vnet\_resource\_group\_name) | n/a |
<!-- END_TF_DOCS -->
