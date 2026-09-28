<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.Networking](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The abbreviation of an environment name.<br/>Possible values are 'dev', 'uat', 'prd', 'sec'. | `string` | `null` | no |
| <a name="input_get_private_DNS_zones"></a> [get\_private\_DNS\_zones](#input\_get\_private\_DNS\_zones) | Whether to get private DNS zones data | `bool` | `true` | no |
| <a name="input_get_subnets"></a> [get\_subnets](#input\_get\_subnets) | Whether to get subnets data | `bool` | `true` | no |
| <a name="input_get_vnet"></a> [get\_vnet](#input\_get\_vnet) | Whether to get VNet data | `bool` | `false` | no |
| <a name="input_get_vnet_resource_group"></a> [get\_vnet\_resource\_group](#input\_get\_vnet\_resource\_group) | Whether to get VNet Resource Group data | `bool` | `false` | no |
| <a name="input_subnet_name_suffix"></a> [subnet\_name\_suffix](#input\_subnet\_name\_suffix) | The name suffix of subnets | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ampls_name"></a> [ampls\_name](#output\_ampls\_name) | # Azure Monitor Private Link Scope Name |
| <a name="output_common_ad_group_oid"></a> [common\_ad\_group\_oid](#output\_common\_ad\_group\_oid) | Common (All users) EntraID group object ID. Group: SG-EAI-AEN-DEV-COM |
| <a name="output_devops_ad_group_oid"></a> [devops\_ad\_group\_oid](#output\_devops\_ad\_group\_oid) | DevOps EntraID group object ID. Group: SG-EAI-AEN-DEV-SRE |
| <a name="output_management_group"></a> [management\_group](#output\_management\_group) | n/a |
| <a name="output_management_group_root"></a> [management\_group\_root](#output\_management\_group\_root) | n/a |
| <a name="output_private_dns_zone"></a> [private\_dns\_zone](#output\_private\_dns\_zone) | n/a |
| <a name="output_psql_backup_policy_name"></a> [psql\_backup\_policy\_name](#output\_psql\_backup\_policy\_name) | n/a |
| <a name="output_resource_group_networking"></a> [resource\_group\_networking](#output\_resource\_group\_networking) | n/a |
| <a name="output_subnet"></a> [subnet](#output\_subnet) | n/a |
| <a name="output_subscription_id"></a> [subscription\_id](#output\_subscription\_id) | n/a |
| <a name="output_tags"></a> [tags](#output\_tags) | n/a |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | ADNOC PrivateSAAS tenant ID |
| <a name="output_terraform_sp_client_id"></a> [terraform\_sp\_client\_id](#output\_terraform\_sp\_client\_id) | Service Principal Client ID for terraform deployments (ADNOC EnergyAI Prod) |
| <a name="output_virtual_network"></a> [virtual\_network](#output\_virtual\_network) | n/a |
<!-- END_TF_DOCS -->
