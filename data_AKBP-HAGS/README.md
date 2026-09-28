<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=4.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_environment"></a> [environment](#input\_environment) | The abbreviation of an environment name.<br/>Possible values are 'dev', 'uat', 'prd', 'sec', 'hub'. | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_allowed_ip_addresses"></a> [allowed\_ip\_addresses](#output\_allowed\_ip\_addresses) | EPAM VPN IP addresses |
| <a name="output_psql_backup_policy_name"></a> [psql\_backup\_policy\_name](#output\_psql\_backup\_policy\_name) | n/a |
| <a name="output_subscription_id"></a> [subscription\_id](#output\_subscription\_id) | n/a |
| <a name="output_tags"></a> [tags](#output\_tags) | n/a |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | EPAM tenant ID |
<!-- END_TF_DOCS -->
