<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >=2.47.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=4.10.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=4.10.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_databricks_access_connector.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_access_connector) | resource |
| [azurerm_databricks_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_workspace) | resource |
| [azurerm_databricks_workspace_root_dbfs_customer_managed_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_workspace_root_dbfs_customer_managed_key) | resource |
| [azurerm_subnet_network_security_group_association.adb_private](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.adb_public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_adb_connector_name"></a> [adb\_connector\_name](#input\_adb\_connector\_name) | (Optional) Specifies the name of the Databricks Access Connector. | `string` | `"temp-adb-connector"` | no |
| <a name="input_adb_dbfs_key_vault_key_id"></a> [adb\_dbfs\_key\_vault\_key\_id](#input\_adb\_dbfs\_key\_vault\_key\_id) | (Required) The resource ID of the Key Vault Key to be used. | `string` | `null` | no |
| <a name="input_adb_managed_rg_name"></a> [adb\_managed\_rg\_name](#input\_adb\_managed\_rg\_name) | (Required) Specifies the name of the managed resource group created for Databricks. | `string` | `"temp-adb-managed"` | no |
| <a name="input_adb_storage_account_name"></a> [adb\_storage\_account\_name](#input\_adb\_storage\_account\_name) | (Optional) Default Databricks File Storage account name.<br/>Only lowercase Alphanumeric characters allowed.<br/>Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_adb_subnet_private_id"></a> [adb\_subnet\_private\_id](#input\_adb\_subnet\_private\_id) | The ID of the Private Subnet for Databricks compute resources. | `string` | n/a | yes |
| <a name="input_adb_subnet_private_name"></a> [adb\_subnet\_private\_name](#input\_adb\_subnet\_private\_name) | The name of the Private Subnet for Databricks compute resources. | `string` | n/a | yes |
| <a name="input_adb_subnet_public_id"></a> [adb\_subnet\_public\_id](#input\_adb\_subnet\_public\_id) | The ID of the Public Subnet for Databricks compute resources. | `string` | n/a | yes |
| <a name="input_adb_subnet_public_name"></a> [adb\_subnet\_public\_name](#input\_adb\_subnet\_public\_name) | The ID of the Public Subnet for Databricks compute resources. | `string` | n/a | yes |
| <a name="input_adb_workspace_name"></a> [adb\_workspace\_name](#input\_adb\_workspace\_name) | (Required) Specifies the name of the databricks workspace.<br/>Only lowercase Alphanumeric characters allowed.<br/>Changing this forces a new resource to be created.<br/>This must be unique across the entire Azure service, not just within the resource group. | `string` | `"temp-adb-workspace"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resource exists.<br/>Changing this forces a new resource to be created. | `string` | `"uaenorth"` | no |
| <a name="input_managed_disk_cmk_key_vault_key_id"></a> [managed\_disk\_cmk\_key\_vault\_key\_id](#input\_managed\_disk\_cmk\_key\_vault\_key\_id) | Optional) Resource ID of the Key Vault which contains the managed\_disk\_cmk\_key\_vault\_key\_id key. | `string` | `null` | no |
| <a name="input_managed_services_cmk_key_vault_key_id"></a> [managed\_services\_cmk\_key\_vault\_key\_id](#input\_managed\_services\_cmk\_key\_vault\_key\_id) | (Optional) Resource ID of the Key Vault which contains the managed\_services\_cmk\_key\_vault\_key\_id key. | `string` | `null` | no |
| <a name="input_nsg_adb_private_id"></a> [nsg\_adb\_private\_id](#input\_nsg\_adb\_private\_id) | The id of the NSG for Private Subnet Databricks compute resources. | `string` | n/a | yes |
| <a name="input_nsg_adb_public_id"></a> [nsg\_adb\_public\_id](#input\_nsg\_adb\_public\_id) | The ID of the NSG for the Public Subnet used by Databricks compute resources. | `string` | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | name     = (Required) The name of the resource group in which to create the container registry. Changing this forces a new resource to be created.<br/>location = (Required) The location/region where the container registry is created. Changing this forces a new resource to be created.<br/>tags     = (Optional) A mapping of tags to assign to the resource. | <pre>object({<br/>    name     = string<br/>    location = string<br/>    tags     = map(string)<br/>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which to create the databricks workspace.<br/>Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(any)` | `null` | no |
| <a name="input_vnet_id"></a> [vnet\_id](#input\_vnet\_id) | The ID of the Subnet for Databricks compute resources. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_databricks_access_connector_id"></a> [databricks\_access\_connector\_id](#output\_databricks\_access\_connector\_id) | The ID of the Databricks Access Connector. |
| <a name="output_databricks_managed_resource_group"></a> [databricks\_managed\_resource\_group](#output\_databricks\_managed\_resource\_group) | The name of the managed resource group created by Databricks. |
| <a name="output_databricks_private_subnet_id"></a> [databricks\_private\_subnet\_id](#output\_databricks\_private\_subnet\_id) | The ID of the private subnet used by Databricks. |
| <a name="output_databricks_public_subnet_id"></a> [databricks\_public\_subnet\_id](#output\_databricks\_public\_subnet\_id) | The ID of the public subnet used by Databricks. |
| <a name="output_databricks_root_dbfs_cmk_key_id"></a> [databricks\_root\_dbfs\_cmk\_key\_id](#output\_databricks\_root\_dbfs\_cmk\_key\_id) | The Key Vault Key ID used for DBFS encryption. |
| <a name="output_databricks_workspace_id"></a> [databricks\_workspace\_id](#output\_databricks\_workspace\_id) | The ID of the Databricks workspace. |
| <a name="output_databricks_workspace_name"></a> [databricks\_workspace\_name](#output\_databricks\_workspace\_name) | The name of the Databricks workspace. |
| <a name="output_databricks_workspace_url"></a> [databricks\_workspace\_url](#output\_databricks\_workspace\_url) | The URL of the Databricks workspace. |
<!-- END_TF_DOCS -->
