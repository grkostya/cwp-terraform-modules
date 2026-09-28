<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 3.1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=4.18.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.3.2 |
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
| [azurerm_app_service_virtual_network_swift_connection.netwrok_integration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_virtual_network_swift_connection) | resource |
| [azurerm_application_insights.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_linux_function_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app) | resource |
| [azurerm_service_plan.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |
| [time_static.now](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_insights_name"></a> [app\_insights\_name](#input\_app\_insights\_name) | Name to create the Application Insights resource. If provided, external values must not be provided. | `string` | `""` | no |
| <a name="input_app_service_plan_name"></a> [app\_service\_plan\_name](#input\_app\_service\_plan\_name) | Name of the App Service Plan when a new plan is created. Must be provided if no existing plan is used. | `string` | `""` | no |
| <a name="input_application_insights_external"></a> [application\_insights\_external](#input\_application\_insights\_external) | n/a | <pre>object({<br/>    connection_string   = string<br/>    instrumentation_key = string<br/>  })</pre> | <pre>{<br/>  "connection_string": "",<br/>  "instrumentation_key": ""<br/>}</pre> | no |
| <a name="input_cors_allowed_origins"></a> [cors\_allowed\_origins](#input\_cors\_allowed\_origins) | n/a | `list(string)` | `[]` | no |
| <a name="input_cors_support_credentials"></a> [cors\_support\_credentials](#input\_cors\_support\_credentials) | n/a | `bool` | `false` | no |
| <a name="input_create_service_plan"></a> [create\_service\_plan](#input\_create\_service\_plan) | Whether the module should create a new App Service Plan. | `bool` | `true` | no |
| <a name="input_existing_app_service_plan_id"></a> [existing\_app\_service\_plan\_id](#input\_existing\_app\_service\_plan\_id) | ID of an existing App Service Plan. If provided, a new plan will not be created. | `string` | `null` | no |
| <a name="input_function_app_name"></a> [function\_app\_name](#input\_function\_app\_name) | Name of the Function App | `string` | `"DS-DEV-OsduRouter-AzureFunction"` | no |
| <a name="input_function_storage_account_name"></a> [function\_storage\_account\_name](#input\_function\_storage\_account\_name) | Storage Account name | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input\_identity) | type         = (Required) Specifies the type of Managed Service Identity that should be<br/>               configured on this Function App.<br/>               Possible values are 'SystemAssigned' or 'UserAssigned'.<br/>identity\_ids = (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to<br/>               this Function App. This is required when type is set to 'UserAssigned'.<br/>               Currently only one User Assigned Identity is supported.<br/>      NOTE:<br/>            type = "UserAssigned" ## To use wiht an existing private DNS zone<br/>            identity\_ids = [azurerm\_user\_assigned\_identity.*.id] | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | <pre>{<br/>  "identity_ids": [],<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_law_id"></a> [law\_id](#input\_law\_id) | (Required)  Specifies the id of a log analytics workspace resource. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location of the Azure resources | `string` | `"uaenorth"` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | name     = (Required) The name of the resource group in which to create the container registry. Changing this forces a new resource to be created.<br/>location = (Required) The location/region where the container registry is created. Changing this forces a new resource to be created.<br/>tags     = (Optional) A mapping of tags to assign to the resource. | <pre>object({<br/>    name     = string<br/>    location = string<br/>    tags     = map(string)<br/>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the Resource Group, this is precreated resource group | `string` | n/a | yes |
| <a name="input_service_plan_os_type"></a> [service\_plan\_os\_type](#input\_service\_plan\_os\_type) | Operating system type for the App Service Plan (Linux or Windows). | `string` | `"Linux"` | no |
| <a name="input_service_plan_sku"></a> [service\_plan\_sku](#input\_service\_plan\_sku) | Service Plan SKU | `string` | `"P2v3"` | no |
| <a name="input_swift_subnet_id"></a> [swift\_subnet\_id](#input\_swift\_subnet\_id) | Function Swift Subnet ID | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_insights_id"></a> [app\_insights\_id](#output\_app\_insights\_id) | n/a |
| <a name="output_id"></a> [id](#output\_id) | ID of the created Function App |
| <a name="output_instrumentation_key"></a> [instrumentation\_key](#output\_instrumentation\_key) | Output the Application Insights instrumentation key. |
| <a name="output_name"></a> [name](#output\_name) | Name of the created Function App |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | n/a |
| <a name="output_service_plan_id"></a> [service\_plan\_id](#output\_service\_plan\_id) | n/a |
<!-- END_TF_DOCS -->
