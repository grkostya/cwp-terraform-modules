### Naming

The module is based on the ["Azure/naming/azurerm"](https://registry.terraform.io/modules/Azure/naming/azurerm/latest) module

<br>

---

### `custom` resource names:
- API Management
- MS Fabric Capacity
- MS Fabric Workspace
- Key Vault
- Storage Account
- User-Assignemd Managed Identity

<br>

---

#### Examples

~~~t
locals {
  env  = "DEV"
  tags = {}
}


module "naming" {
  source           = "../../../modules/naming"
  application_code = "My-App"
  environment      = local.env
}


## Using the official 'azure' naming module output
resource "azurerm_resource_group" "this" {
  name = module.naming.azure.resource_group.name

  location = var.location.name
  tags     = local.tags
}


## Using the official 'azure' naming module output with a random unique suffix
resource "azurerm_log_analytics_workspace" "this" {
  name = module.naming.azure.log_analytics_workspace.name_unique

  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}


## Using the 'custom' redefined output
resource "azurerm_user_assigned_identity" "this" {
  name = module.naming.custom.user_assigned_identity.name

  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  tags                = local.tags
}


## Using only the 'name_suffix' output
resource "azurerm_dev_center" "this" {
  name = "devcenter-${module.naming.name_suffix}"

  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}
~~~

---

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=4.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.3.2 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_naming"></a> [naming](#module\_naming) | git::https://github.com/Azure/terraform-azurerm-naming | 0.4.3 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_code"></a> [application\_code](#input\_application\_code) | The part of the naming convention that specifies the purpose of an application or service. | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The abbreviation of an environment name.<br/>Possible values are 'dev', 'uat', 'stg', 'ppr', 'prd', 'tst', 'shr', 'trn', 'dbg', 'dem', 'sec', 'hub'. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | name       = (Required) The Azure Region where resources should exist.<br/>             Changing this forces a new resource to be created.<br/>short\_name = The Azure Region Abbreviation. Will be used as a part of a resource name<br/>             according to the naming convention. | <pre>object({<br/>    name       = string<br/>    short_name = string<br/>  })</pre> | <pre>{<br/>  "name": "northeurope",<br/>  "short_name": "neu"<br/>}</pre> | no |
| <a name="input_number"></a> [number](#input\_number) | n/a | `string` | `"001"` | no |
| <a name="input_subscription_code"></a> [subscription\_code](#input\_subscription\_code) | The short code of a subscription. | `string` | `"nrgi"` | no |
| <a name="input_unique-include-numbers"></a> [unique-include-numbers](#input\_unique-include-numbers) | Whether to include numbers in the unique generation. | `bool` | `true` | no |
| <a name="input_unique-length"></a> [unique-length](#input\_unique-length) | Max length of the uniqueness suffix to be added. | `number` | `4` | no |
| <a name="input_unique-seed"></a> [unique-seed](#input\_unique-seed) | Custom value for the random characters to be used. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_code"></a> [application\_code](#output\_application\_code) | n/a |
| <a name="output_azure"></a> [azure](#output\_azure) | n/a |
| <a name="output_custom"></a> [custom](#output\_custom) | n/a |
| <a name="output_location"></a> [location](#output\_location) | n/a |
| <a name="output_name_suffix"></a> [name\_suffix](#output\_name\_suffix) | n/a |
| <a name="output_networking"></a> [networking](#output\_networking) | n/a |
| <a name="output_number"></a> [number](#output\_number) | n/a |
| <a name="output_subscription_code"></a> [subscription\_code](#output\_subscription\_code) | n/a |
| <a name="output_unique-seed"></a> [unique-seed](#output\_unique-seed) | n/a |
<!-- END_TF_DOCS -->
