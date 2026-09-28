<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 3.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=4.25.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >=0.13.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=4.25.0 |
| <a name="provider_time"></a> [time](#provider\_time) | >=0.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_cognitive_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account) | resource |
| [time_static.now](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_custom_subdomain_name"></a> [custom\_subdomain\_name](#input\_custom\_subdomain\_name) | (Optional) The subdomain name used for token-based authentication.<br/>Required when:<br/>  - `network_acls` is specified;<br/>  - using the OpenAI service with libraries expecting endpoint like `https://<subdomain>.openai.azure.com/`.<br/>Changing this value forces a new resource to be created. | `string` | `null` | no |
| <a name="input_customer_managed_key"></a> [customer\_managed\_key](#input\_customer\_managed\_key) | key\_vault\_key\_id   = (Required) The ID of the Key Vault Key which should be used<br/>                     to Encrypt the data in this Cognitive Account.<br/>identity\_client\_id = (Optional) The Client ID of the User Assigned Identity that<br/>                      has access to the key. This property only needs to be specified<br/>                      when there're multiple identities attached to the Cognitive Account. | <pre>object({<br/>    key_vault_key_id   = string<br/>    identity_client_id = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_dynamic_throttling_enabled"></a> [dynamic\_throttling\_enabled](#input\_dynamic\_throttling\_enabled) | (Optional) Whether to enable the dynamic throttling for this Cognitive Service Account | `bool` | `false` | no |
| <a name="input_fqdns"></a> [fqdns](#input\_fqdns) | (Optional) List of FQDNs allowed for the Cognitive Account. | `list(string)` | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | type         = Required) Specifies the type of Managed Service Identity that should be<br/>               configured on this Cognitive Account. Possible values are<br/>               'SystemAssigned', 'UserAssigned', 'SystemAssigned, UserAssigned' (to enable both).<br/>identity\_ids = (Optional) Specifies a list of User Assigned Managed Identity IDs to be<br/>               assigned to this Cognitive Account. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_kind"></a> [kind](#input\_kind) | Specifies the kind of Cognitive Service Account to be created. | `string` | n/a | yes |
| <a name="input_local_auth_enabled"></a> [local\_auth\_enabled](#input\_local\_auth\_enabled) | (Optional) Whether local authentication methods is enabled for the Cognitive Account. Defaults to 'false' | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | Location of the Azure resources | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the Cognitive Service name. | `string` | `null` | no |
| <a name="input_network_acls"></a> [network\_acls](#input\_network\_acls) | bypass         = (Optional) Whether to allow trusted Azure Services to access the service.<br/>                 Possible values are 'None' and 'AzureServices'.<br/>                 NOTE:<br/>                    'bypass' can only be set when 'kind' is set to 'OpenAI'<br/>default\_action = (Required) The Default Action to use when no rules match from<br/>                 'ip\_rules' / 'virtual\_network\_rules'. Possible values are 'Allow' and 'Deny'.<br/>ip\_rules       = (Optional) One or more IP Addresses, or CIDR Blocks which should be<br/>                 able to access the Cognitive Account.<br/>virtual\_network\_rules = {<br/>  subnet\_id                            = (Required) The ID of the subnet which should be<br/>                                         able to access this Cognitive Account.<br/>  ignore\_missing\_vnet\_service\_endpoint = (Optional) Whether ignore missing<br/>                                         vnet service endpoint or not. Default to 'false'.<br/>} | <pre>set(object({<br/>    bypass         = optional(string, null)<br/>    default_action = string<br/>    ip_rules       = optional(set(string))<br/>    virtual_network_rules = optional(set(object({<br/>      subnet_id                            = string<br/>      ignore_missing_vnet_service_endpoint = optional(bool, false)<br/>    })))<br/>  }))</pre> | `null` | no |
| <a name="input_network_injection"></a> [network\_injection](#input\_network\_injection) | (Optional) Injects the AIServices account into a virtual network subnet.<br/>Only valid when 'kind' is set to 'AIServices'.<br/>subnet\_id = (Required) The resource ID of the subnet to inject into. | <pre>object({<br/>    subnet_id = string<br/>  })</pre> | `null` | no |
| <a name="input_project_management_enabled"></a> [project\_management\_enabled](#input\_project\_management\_enabled) | (Optional) Whether project management is enabled when the kind is set to 'AIServices'.<br/>Once enabled, 'project\_management\_enabled' cannot be disabled.<br/>Changing this forces a new resource to be created.<br/>Defaults to false. | `bool` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is allowed for the Cognitive Account. | `bool` | `false` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Predefined resource group object. | <pre>object({<br/>    name     = string<br/>    location = string<br/>    tags     = map(string)<br/>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the Resource Group, this is precreated resource group | `string` | `null` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Specifies the SKU Name for the Cognitive Service Account. | `string` | n/a | yes |
| <a name="input_storage"></a> [storage](#input\_storage) | storage\_account\_id = (Required) Full resource id of a Microsoft.Storage resource.<br/>identity\_client\_id = (Optional) The client ID of the managed identity associated with the storage resource. | <pre>object({<br/>    storage_account_id = string<br/>    identity_client_id = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_cognitive_account_endpoint"></a> [cognitive\_account\_endpoint](#output\_cognitive\_account\_endpoint) | The endpoint URL of the Cognitive Services account. |
| <a name="output_cognitive_account_primary_access_key"></a> [cognitive\_account\_primary\_access\_key](#output\_cognitive\_account\_primary\_access\_key) | The primary access key of the Cognitive Services account. |
| <a name="output_cognitive_account_secondary_access_key"></a> [cognitive\_account\_secondary\_access\_key](#output\_cognitive\_account\_secondary\_access\_key) | The secondary access key of the Cognitive Services account. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Cognitive Services account. |
| <a name="output_identity"></a> [identity](#output\_identity) | The Cognitive Services Identity. |
| <a name="output_location"></a> [location](#output\_location) | The location of the Cognitive Services account. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Cognitive Services account. |
<!-- END_TF_DOCS -->
