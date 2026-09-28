<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 3.1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=4.18.0 |
| <a name="requirement_fabric"></a> [fabric](#requirement\_fabric) | 1.1.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >=0.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=4.18.0 |
| <a name="provider_time"></a> [time](#provider\_time) | >=0.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_fabric_capacity.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/fabric_capacity) | resource |
| [time_static.now](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |
| [azurerm_client_config.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_fabric_capacity_admin_upns"></a> [fabric\_capacity\_admin\_upns](#input\_fabric\_capacity\_admin\_upns) | Collection of admin UPNs for the Fabric Capacity. | `set(string)` | `[]` | no |
| <a name="input_fabric_capacity_name"></a> [fabric\_capacity\_name](#input\_fabric\_capacity\_name) | Name of the solution | `string` | n/a | yes |
| <a name="input_fabric_capacity_sku"></a> [fabric\_capacity\_sku](#input\_fabric\_capacity\_sku) | Fabric Capacity SKU name | `string` | `"F2"` | no |
| <a name="input_location"></a> [location](#input\_location) | Location of the Azure resources | `string` | `"uaenorth"` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | name     = (Required) The name of the resource group in which to create the container registry. Changing this forces a new resource to be created.<br/>location = (Required) The location/region where the container registry is created. Changing this forces a new resource to be created.<br/>tags     = (Optional) A mapping of tags to assign to the resource. | <pre>object({<br/>    name     = string<br/>    location = string<br/>    tags     = map(string)<br/>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the Resource Group, this is precreated resource group | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Fabric Capacity ID |
| <a name="output_name"></a> [name](#output\_name) | The Fabric Capacity Name |
<!-- END_TF_DOCS -->
