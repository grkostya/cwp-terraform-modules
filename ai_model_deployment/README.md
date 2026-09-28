<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=4.0.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >=0.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_cognitive_deployment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_deployment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cognitive_account_id"></a> [cognitive\_account\_id](#input\_cognitive\_account\_id) | The ID of the Cognitive Services Account | `string` | n/a | yes |
| <a name="input_model"></a> [model](#input\_model) | format  = (Required) The format of the Cognitive Services Account Deployment model.<br/>          Changing this forces a new resource to be created. Possible value is 'OpenAI'.<br/>name    = (Required) The name of the model.<br/>version = (Optional) The version of Cognitive Services Account Deployment model.<br/>          If version is not specified, the default version of the model at the time<br/>          will be assigned. | <pre>object({<br/>    format  = optional(string, "OpenAI")<br/>    name    = string<br/>    version = optional(string)<br/>  })</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Cognitive Deployment | `string` | n/a | yes |
| <a name="input_rai_policy_name"></a> [rai\_policy\_name](#input\_rai\_policy\_name) | The name of the RAI policy. Options: 'Microsoft.Default', 'Microsoft.DefaultV2' | `string` | `"Microsoft.DefaultV2"` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | name     = (Required) The name of the SKU. Possible values include<br/>           'Standard', 'DataZoneBatch', 'DataZoneStandard', 'DataZoneProvisionedManaged',<br/>           'GlobalBatch', 'GlobalProvisionedManaged', 'GlobalStandard', and 'ProvisionedManaged'.<br/>    NOTE:<br/>        'DataZoneProvisionedManaged', 'GlobalProvisionedManaged', and 'ProvisionedManaged'<br/>        are purchased on-demand at an hourly basis based on the number of deployed PTUs,<br/>        with substantial term discount available via the purchase of Azure Reservations.<br/>        Currently, this step cannot be completed using Terraform.<br/>        For more details, please refer to the provisioned throughput onboarding documentation(https://learn.microsoft.com/en-us/azure/ai-services/openai/how-to/provisioned-throughput-onboarding).<br/>tier     = (Optional) Possible values are 'Free', 'Basic', 'Standard', 'Premium', 'Enterprise'.<br/>           This property is required only when multiple tiers are available with the SKU name.<br/>           Changing this forces a new resource to be created.<br/>size     = (Optional) The SKU size. When the name field is the combination of<br/>           tier and some other value, this would be the standalone code.<br/>           Changing this forces a new resource to be created.<br/>family   = (Optional) If the service has different generations of hardware,<br/>           for the same SKU, then that can be captured here.<br/>           Changing this forces a new resource to be created.<br/>capacity = (Optional) Tokens-per-Minute (TPM). The unit of measure for this field is<br/>           in the thousands of Tokens-per-Minute. Defaults to '1' which means that<br/>           the limitation is 1000 tokens per minute. If the resources SKU supports<br/>           scale in/out then the capacity field should be included in the resources' configuration.<br/>           If the scale in/out is not supported by the resources SKU then this field can be<br/>           safely omitted. For more information about TPM please see the product documentation(https://learn.microsoft.com/azure/ai-services/openai/how-to/quota?tabs=rest). | <pre>object({<br/>    name     = string<br/>    tier     = optional(string)<br/>    size     = optional(string)<br/>    family   = optional(string)<br/>    capacity = optional(number, 1)<br/>  })</pre> | n/a | yes |
| <a name="input_version_upgrade_option"></a> [version\_upgrade\_option](#input\_version\_upgrade\_option) | (Optional) Deployment model version upgrade option. Possible values are<br/>'OnceNewDefaultVersionAvailable', 'OnceCurrentVersionExpired', and 'NoAutoUpgrade'.<br/>Defaults to 'OnceNewDefaultVersionAvailable'. | `string` | `"OnceNewDefaultVersionAvailable"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
