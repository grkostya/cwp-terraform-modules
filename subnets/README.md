<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | A map of additional tags to apply to all resources created by this module.<br/>These tags will be merged with the default tags provided by the module.<br/>Example:<br/>  additional\_tags = {<br/>  "Environment" = "Production"<br/>  "Owner"       = "DevOps Team"<br/>} | `map(string)` | `{}` | no |
| <a name="input_address_prefixes"></a> [address\_prefixes](#input\_address\_prefixes) | A list of CIDR blocks representing the address space for the subnet(s).<br/>Each entry in the list defines a subnet range within the virtual network.<br/>Example: ["10.0.1.0/24", "10.0.2.0/24"] | `list(string)` | n/a | yes |
| <a name="input_delegation"></a> [delegation](#input\_delegation) | Specifies the delegation settings for the subnet. This allows a subnet to be explicitly delegated to a specific Azure service.<br/>- `name`: The name of the delegation.<br/>- `service_delegation`: An object that defines the service delegation.<br/>- `name`: The name of the Azure service to which the subnet is delegated.<br/>- `actions`: (Optional) A list of actions that define the permissions granted to the service.<br/>Example:<br/>delegation = { name = "example-delegation" service\_delegation = { name = "Microsoft.Web/serverFarms" actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"] } } | <pre>object({<br/>    name = string<br/>    service_delegation = object({<br/>      name    = string<br/>      actions = optional(list(string), [])<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_nsg_resource_group"></a> [nsg\_resource\_group](#input\_nsg\_resource\_group) | name     = (Required) The name of the resource group in which to create the NSG.<br/>location = (Required) The location/region where the NSG resource group is created.<br/>tags     = (Optional) A mapping of tags assigned to the resource. | <pre>object({<br/>    name     = string<br/>    location = string<br/>    tags     = map(string)<br/>  })</pre> | `null` | no |
| <a name="input_nsg_rules"></a> [nsg\_rules](#input\_nsg\_rules) | priority                                   = (Required) Specifies the priority of the rule. The value can be between '100' and '4096'. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.<br/>direction                                  = (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are 'Inbound' and 'Outbound'.<br/>access                                     = (Required) Specifies whether network traffic is allowed or denied. Possible values are 'Allow' and 'Deny'.<br/>source\_address\_prefix                      = (Optional) CIDR or source IP range or * to match any IP. Tags such as 'VirtualNetwork', 'AzureLoadBalancer' and 'Internet' can also be used. This is required if 'source\_address\_prefixes' is not specified.<br/>source\_address\_prefixes                    = (Optional) List of source address prefixes. Tags may not be used. This is required if 'source\_address\_prefix' is not specified.<br/>source\_port\_range                          = (Optional) Source Port or Range. Integer or range between '0' and '65535' or '*' to match any. This is required if 'source\_port\_ranges' is not specified.<br/>source\_port\_ranges                         = (Optional) List of source ports or port ranges. This is required if 'source\_port\_range' is not specified.<br/>source\_application\_security\_group\_ids      = (Optional) A List of source Application Security Group IDs.<br/>destination\_address\_prefix                 = (Optional) CIDR or destination IP range or * to match any IP. Tags such as 'VirtualNetwork', 'AzureLoadBalancer' and 'Internet' can also be used. This is required if 'destination\_address\_prefixes' is not specified.<br/>destination\_address\_prefixes               = (Optional) List of destination address prefixes. Tags may not be used. This is required if 'destination\_address\_prefix' is not specified.<br/>destination\_application\_security\_group\_ids = (Optional) A List of destination Application Security Group IDs.<br/>destination\_port\_range                     = (Optional) Destination Port or Range. Integer or range between '0' and '65535' or '*' to match any. This is required if 'destination\_port\_ranges' is not specified.<br/>destination\_port\_ranges                    = (Optional) List of destination ports or port ranges. This is required if 'destination\_port\_range' is not specified.<br/>protocol                                   = (Required) Network protocol this rule applies to. Possible values include 'Tcp', 'Udp', 'Icmp', 'Esp', 'Ah' or '*' (which matches all)<br/>description                                = (Optional) A description for this rule. Restricted to 140 characters. | <pre>map(object({<br/>    priority                                   = number<br/>    direction                                  = string<br/>    access                                     = string<br/>    source_address_prefix                      = optional(string)<br/>    source_address_prefixes                    = optional(list(string))<br/>    source_port_range                          = optional(string)<br/>    source_port_ranges                         = optional(list(string))<br/>    source_application_security_group_ids      = optional(list(string))<br/>    destination_address_prefix                 = optional(string)<br/>    destination_address_prefixes               = optional(list(string))<br/>    destination_application_security_group_ids = optional(list(string))<br/>    destination_port_range                     = optional(string)<br/>    destination_port_ranges                    = optional(list(string))<br/>    protocol                                   = string<br/>    description                                = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_route_table_id"></a> [route\_table\_id](#input\_route\_table\_id) | The ID of the route table to associate with the subnet.<br/>This ensures that the subnet follows specific routing rules<br/>defined in the provided route table. | `string` | `null` | no |
| <a name="input_service_endpoints"></a> [service\_endpoints](#input\_service\_endpoints) | A list of service endpoints to associate with the subnet.<br/>  These endpoints allow private access to Azure services without traversing the public internet.<br/>E xample values: ["Microsoft.Storage", "Microsoft.Sql", "Microsoft.KeyVault"] | `list(string)` | n/a | yes |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | (Required) Specifies the name of the subnet. | `string` | n/a | yes |
| <a name="input_use_udr"></a> [use\_udr](#input\_use\_udr) | Whether to associate a user-defined route table with the subnet? | `bool` | `true` | no |
| <a name="input_vnet"></a> [vnet](#input\_vnet) | The `vnet` variable is an object that defines the details of the virtual network.<br/><br/>- `name`                = The name of the virtual network.<br/>- `resource_group_name` = The name of the resource group where the virtual network is deployed.<br/>- `location`            = The Azure region where the virtual network is created.<br/>- `tags`                = A map of tags assigned to the virtual network. | <pre>object({<br/>    name                = string<br/>    resource_group_name = string<br/>    location            = string<br/>    tags                = map(string)<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_nsg_id"></a> [nsg\_id](#output\_nsg\_id) | n/a |
<!-- END_TF_DOCS -->
