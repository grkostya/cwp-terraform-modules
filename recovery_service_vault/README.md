<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.25 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >=0.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 4.25 |
| <a name="provider_time"></a> [time](#provider\_time) | >=0.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_recovery_services_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/recovery_services_vault) | resource |
| [time_static.now](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cross_region_restore_enabled"></a> [cross\_region\_restore\_enabled](#input\_cross\_region\_restore\_enabled) | (Optional) Is cross region restore enabled for this Vault?<br/>Only can be 'true', when 'storage\_mode\_type' is 'GeoRedundant'. Defaults to 'false'.<br/><br/>Note:<br/>  Once 'cross\_region\_restore\_enabled' is set to 'true', changing it back to 'false' forces<br/>  a new Recovery Service Vault to be created. | `string` | `false` | no |
| <a name="input_encryption"></a> [encryption](#input\_encryption) | infrastructure\_encryption\_enabled = (Required) Enabling/Disabling the Double Encryption state.<br/>key\_id                            = (Required) The Key Vault key id used to encrypt this vault.<br/>                                    Key managed by Vault Managed Hardware Security Module is also supported.<br/>user\_assigned\_identity\_id         = (Optional) Specifies the user assigned identity ID to be used.<br/>use\_system\_assigned\_identity      = (Optional) Indicate that system assigned identity should be used or not.<br/>                                    Defaults to 'true'. Must be set to 'false' when 'user\_assigned\_identity\_id' is set.<br/>Note:<br/>  'use\_system\_assigned\_identity' only be able to set to 'false' for new vaults.<br/>  Any vaults containing existing items registered or attempted to be registered to it<br/>  are not supported. Details can be found in the document (https://learn.microsoft.com/en-us/azure/backup/encryption-at-rest-with-cmk?tabs=portal#before-you-start)<br/><br/>Note:<br/>  Once 'infrastructure\_encryption\_enabled' has been set it's not possible to change it. | <pre>object({<br/>    infrastructure_encryption_enabled = optional(bool, true)<br/>    key_id                            = string<br/>    user_assigned_identity_id         = optional(string)<br/>    # use_system_assigned_identity      = optional(bool) ## Defined in locals<br/>  })</pre> | <pre>{<br/>  "key_id": null<br/>}</pre> | no |
| <a name="input_identity"></a> [identity](#input\_identity) | type = (Required) Specifies the type of Managed Service Identity that should be configured on this Recovery Services Vault.<br/>       Possible values are 'SystemAssigned', 'UserAssigned', 'SystemAssigned, UserAssigned' (to enable both).<br/>ids  = (Optional) A list of User Assigned Identity IDs to be associated with the Recovery Services Vault. | <pre>object({<br/>    type = optional(string)<br/>    ids  = list(string)<br/>  })</pre> | <pre>{<br/>  "ids": []<br/>}</pre> | no |
| <a name="input_immutability"></a> [immutability](#input\_immutability) | (Optional) Immutability Settings of vault, possible values include: 'Locked', 'Unlocked' and 'Disabled'.<br/><br/>Note:<br/>  Once 'immutability' is set to 'Locked', changing it to other values forces a new Recovery Services Vault to be created. | `string` | `"Disabled"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resource exists.<br/>Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the Recovery Services Vault.<br/>Recovery Service Vault name must be 2 - 50 characters long, start with a letter,<br/>contain only letters, numbers and hyphens. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Is it enabled to access the vault from public networks. Defaults to 'false'. | `bool` | `false` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | name     = (Required) The name of the resource group in which to create the resource. Changing this forces a new resource to be created.<br/>location = (Required) The location/region where the resource is created. Changing this forces a new resource to be created.<br/>tags     = (Optional) A mapping of tags to assign to the resource. | <pre>object({<br/>    name     = string<br/>    location = string<br/>    tags     = map(string)<br/>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which to create the resource.<br/>Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | (Required) Sets the vault's SKU. Possible values include: 'Standard', 'RS0'. | `string` | `"Standard"` | no |
| <a name="input_soft_delete_enabled"></a> [soft\_delete\_enabled](#input\_soft\_delete\_enabled) | (Optional) Is soft delete enable for this Vault? Defaults to 'true'. | `bool` | `true` | no |
| <a name="input_storage_mode_type"></a> [storage\_mode\_type](#input\_storage\_mode\_type) | (Optional) The storage type of the Recovery Services Vault.<br/>Possible values are 'GeoRedundant', 'LocallyRedundant' and 'ZoneRedundant'. Defaults to 'GeoRedundant'. | `string` | `"GeoRedundant"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->
