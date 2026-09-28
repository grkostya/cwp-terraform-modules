<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=4.10.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >=0.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=4.10.0 |
| <a name="provider_time"></a> [time](#provider\_time) | >=0.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_machine_learning_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_workspace) | resource |
| [time_static.now](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_insights_id"></a> [application\_insights\_id](#input\_application\_insights\_id) | (Required) The ID of the Application Insights associated with this Machine Learning Workspace. | `string` | n/a | yes |
| <a name="input_container_registry_id"></a> [container\_registry\_id](#input\_container\_registry\_id) | (Required) The container registry ID for the ML workspace. | `string` | n/a | yes |
| <a name="input_customer_managed_key"></a> [customer\_managed\_key](#input\_customer\_managed\_key) | n/a | <pre>object({<br/>    key_vault_id              = string<br/>    key_vault_key_id          = string<br/>    user_assigned_identity_id = string<br/>  })</pre> | `null` | no |
| <a name="input_high_business_impact"></a> [high\_business\_impact](#input\_high\_business\_impact) | Flag to signal High Business Impact (HBI) data in the workspace and reduce diagnostic data collected by the service.<br/>More info, can be found here: https://learn.microsoft.com/en-us/azure/machine-learning/concept-data-encryption?view=azureml-api-2#encryption-at-rest<br/>NOTE:<br/>Changing this flag forces a new resource to be created. | `string` | `true` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | type         = (Required) Specifies the type of Managed Service Identity<br/>               that should be configured on this ML workspace.<br/>               Possible values are 'SystemAssigned', 'UserAssigned',<br/>               'SystemAssigned, UserAssigned' (to enable both).<br/>identity\_ids = (Optional) Specifies a list of User Assigned Managed Identity IDs<br/>                to be assigned to this Storage Account.<br/>                This is required when type is set to 'UserAssigned' or 'SystemAssigned, UserAssigned'.<br/>NOTE:<br/>The assigned 'principal\_id' and 'tenant\_id' can be retrieved after the identity 'type'<br/>has been set to 'SystemAssigned' and ML workspace has been created. | <pre>object({<br/>    type         = optional(string)<br/>    identity_ids = optional(set(string))<br/>  })</pre> | `null` | no |
| <a name="input_image_build_compute_name"></a> [image\_build\_compute\_name](#input\_image\_build\_compute\_name) | (Optional) The compute name for image build of the Machine Learning Workspace. | `string` | `null` | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | (Required) The keyvault ID for the ML workspace. | `string` | n/a | yes |
| <a name="input_legacy_mode_enabled"></a> [legacy\_mode\_enabled](#input\_legacy\_mode\_enabled) | Enable V1 API features, enabling this mode may prevent you from using features provided by the v2 API. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resource exists.<br/>Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the ML workspace. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Enable public network access to the Machine Learning Workspace.<br/>When enabled, combine with allowed\_ip\_addresses to restrict access to specific IP ranges<br/>via the associated resources (storage account network rules, key vault network ACLs, NSGs). | `bool` | `false` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | name     = (Required) The name of the resource group in which to create the container registry. Changing this forces a new resource to be created.<br/>location = (Required) The location/region where the container registry is created. Changing this forces a new resource to be created.<br/>tags     = (Optional) A mapping of tags to assign to the resource. | <pre>object({<br/>    name     = string<br/>    location = string<br/>    tags     = map(string)<br/>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which to create the container registry.<br/>Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_serverless_compute_subnet_id"></a> [serverless\_compute\_subnet\_id](#input\_serverless\_compute\_subnet\_id) | (Required) The subnet ID for the ML workspace serverless compute. Can be the same as for ML workspaces | `string` | n/a | yes |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | (Required) The storage account ID for the ML workspace. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_mlw"></a> [mlw](#output\_mlw) | n/a |
<!-- END_TF_DOCS -->
