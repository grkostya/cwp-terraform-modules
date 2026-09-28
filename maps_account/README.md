<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >=3.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=4.25.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >=0.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=4.25.0 |
| <a name="provider_time"></a> [time](#provider\_time) | >=0.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_maps_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/maps_account) | resource |
| [time_static.now](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cors"></a> [cors](#input\_cors) | (Optional) A list of CORS rules for the Maps Account.<br/>Example:<br/>[<br/>  {<br/>    allowed\_origins = ["https://example.com"]<br/>  }<br/>] | <pre>list(object({<br/>    allowed_origins = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_data_store"></a> [data\_store](#input\_data\_store) | (Optional) List of data\_store blocks.<br/>Example:<br/>[<br/>  {<br/>    storage\_account\_id = "..."<br/>    unique\_name        = "somename"<br/>  }<br/>] | <pre>list(object({<br/>    storage_account_id = string<br/>    unique_name        = string<br/>  }))</pre> | `[]` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) Managed Service Identity configuration.<br/>Example:<br/>{<br/>  type         = "SystemAssigned"<br/>  identity\_ids = ["id1", "id2"] # Optional<br/>} | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_local_authentication_enabled"></a> [local\_authentication\_enabled](#input\_local\_authentication\_enabled) | (Optional) Is local authentication enabled for this Azure Maps Account? When false, disables all local keys except AAD. Defaults to true. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure location for the Maps account. | `string` | `"westeurope"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Azure Maps account. | `string` | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | name     = (Required) The name of the resource group in which to create the CosmosDB Account. Changing this forces a new resource to be created.<br/>location = (Required) The location/region where CosmosDB Account host is created. Changing this forces a new resource to be created.<br/>tags     = (Optional) A mapping of tags to assign to the resource. | <pre>object({<br/>    name     = string<br/>    location = string<br/>    tags     = map(string)<br/>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | `null` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | (Required) The SKU of the Azure Maps Account. | `string` | `"G2"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Maps account. |
| <a name="output_maps_account_primary_key"></a> [maps\_account\_primary\_key](#output\_maps\_account\_primary\_key) | The primary key of the Maps account. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Maps account. |
<!-- END_TF_DOCS -->
