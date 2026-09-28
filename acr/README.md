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
| [azurerm_container_registry.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [time_static.now](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_enabled"></a> [admin\_enabled](#input\_admin\_enabled) | (Optional) Specifies whether the admin user is enabled. Defaults to false. | `bool` | `false` | no |
| <a name="input_anonymous_pull_enabled"></a> [anonymous\_pull\_enabled](#input\_anonymous\_pull\_enabled) | (Optional) Whether allows anonymous (unauthenticated) pull access to this Container Registry. | `bool` | `false` | no |
| <a name="input_customer_managed_key"></a> [customer\_managed\_key](#input\_customer\_managed\_key) | n/a | <pre>object({<br/>    key_vault_key_id                 = string<br/>    user_assigned_identity_id        = string<br/>    user_assigned_identity_client_id = string<br/>  })</pre> | `null` | no |
| <a name="input_export_policy_enabled"></a> [export\_policy\_enabled](#input\_export\_policy\_enabled) | (Optional) Boolean value that indicates whether export policy is enabled. Defaults to false. In order to set it to true, make sure the public\_network\_access\_enabled is also set to true. | `bool` | `false` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | type         = (Required) Specifies the type of Managed Service Identity<br/>               that should be configured on this Container Registry.<br/>               Possible values are 'SystemAssigned', 'UserAssigned',<br/>               'SystemAssigned, UserAssigned' (to enable both).<br/>identity\_ids = (Optional) Specifies a list of User Assigned Managed Identity IDs<br/>                to be assigned to this Container Registry.<br/>                This is required when type is set to 'UserAssigned' or 'SystemAssigned, UserAssigned'.<br/>NOTE:<br/>The assigned 'principal\_id' and 'tenant\_id' can be retrieved after the identity 'type'<br/>has been set to 'SystemAssigned' and Container Registry has been created. | <pre>object({<br/>    type         = optional(string)<br/>    identity_ids = optional(set(string))<br/>  })</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resource exists.<br/>Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the container registry.<br/>Only lowercase Alphanumeric characters allowed.<br/>Changing this forces a new resource to be created.<br/>This must be unique across the entire Azure service, not just within the resource group. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Whether public network access is allowed for the container registry. | `bool` | `false` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | name     = (Required) The name of the resource group in which to create the container registry. Changing this forces a new resource to be created.<br/>location = (Required) The location/region where the container registry is created. Changing this forces a new resource to be created.<br/>tags     = (Optional) A mapping of tags to assign to the resource. | <pre>object({<br/>    name     = string<br/>    location = string<br/>    tags     = map(string)<br/>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which to create the container registry.<br/>Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_retention_policy_in_days"></a> [retention\_policy\_in\_days](#input\_retention\_policy\_in\_days) | (Optional) The number of days to retain and untagged manifest after which it gets purged.<br/>Defaults to 7 | `number` | `7` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | Use to set a SKU for the container registry, by default the SKU will be Premium | `string` | `"Premium"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(any)` | `null` | no |
| <a name="input_zone_redundancy_enabled"></a> [zone\_redundancy\_enabled](#input\_zone\_redundancy\_enabled) | (Optional) Whether zone redundancy is enabled for this Container Registry. Changing this forces a new resource to be created. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acr"></a> [acr](#output\_acr) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->
