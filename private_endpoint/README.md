<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=4.0.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >=0.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=4.0.0 |
| <a name="provider_time"></a> [time](#provider\_time) | >=0.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [time_static.now](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | (Required) The location/region where the bastion host is created. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Private Endpoint. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_private_connection_resource"></a> [private\_connection\_resource](#input\_private\_connection\_resource) | The Private Link Enabled Remote Resource which this Private Endpoint should be connected to. | <pre>object({<br/>    id   = string<br/>    name = string<br/>  })</pre> | n/a | yes |
| <a name="input_private_dns_zone_ids"></a> [private\_dns\_zone\_ids](#input\_private\_dns\_zone\_ids) | (Required) Specifies the list of Private DNS Zones to include within the 'private\_dns\_zone\_group'. | `list(string)` | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | name     = (Required) The name of the resource group in which to create the bastion host. Changing this forces a new resource to be created.<br/>location = (Required) The location/region where the bastion host is created. Changing this forces a new resource to be created.<br/>tags     = (Optional) A mapping of tags to assign to the resource. | <pre>object({<br/>    name     = string<br/>    location = string<br/>    tags     = map(string)<br/>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which to create the bastion host. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Required) The ID of the Subnet from which Private IP Addresses will be allocated for<br/>this Private Endpoint. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_subresource_names"></a> [subresource\_names](#input\_subresource\_names) | (Optional) A list of subresource names which the Private Endpoint is able to connect to.<br/>'subresource\_names' corresponds to 'group\_id'.<br/>Possible values are detailed in the product documentation in the 'Subresources' column.<br/>Changing this forces a new resource to be created.<br/>NOTE:<br/>    Some resource types (such as Storage Account) only support 1 subresource per private endpoint.<br/>NOTE 2:<br/>    For most Private Links one or more subresource\_names will need to be specified,<br/>    please see the linked documentation for details. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(any)` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
