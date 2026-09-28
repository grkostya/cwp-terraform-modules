<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=4.0.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >=0.13.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=4.0.0 |
| <a name="provider_time"></a> [time](#provider\_time) | >=0.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_search_service.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/search_service) | resource |
| [time_static.now](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_allowed_ips"></a> [allowed\_ips](#input\_allowed\_ips) | (Optional) A list of IP addresses or CIDR blocks which are allowed to access the search service. | `list(string)` | `null` | no |
| <a name="input_local_authentication_enabled"></a> [local\_authentication\_enabled](#input\_local\_authentication\_enabled) | (Optional) Specifies whether local authentication is enabled for this resource. Defaults to 'false'. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The location/region where the bastion host is created. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the AI Search. Changing this forces a new resource to be created.<br/>The name must be globally unique. If the vault is in a recoverable state then<br/>the vault will need to be purged before reusing the name. | `string` | n/a | yes |
| <a name="input_partition_count"></a> [partition\_count](#input\_partition\_count) | Partitions allow for scaling of document count as well as faster indexing by sharding your<br/>index over multiple search units.<br/>NOTE:<br/>  When 'hosting\_mode' is set to 'highDensity' the maximum number of partitions allowed is '3'. | `number` | `1` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Specifies whether Public Network Access is allowed for this resource.<br/>Defaults to 'false' | `bool` | `false` | no |
| <a name="input_replica_count"></a> [replica\_count](#input\_replica\_count) | Replicas distribute search workloads across the service. You need at least two replicas to support high availability of query workloads (not applicable to the free tier). | `number` | `1` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | name     = (Required) The name of the resource group in which to create the bastion host. Changing this forces a new resource to be created.<br/>location = (Required) The location/region where the bastion host is created. Changing this forces a new resource to be created.<br/>tags     = (Optional) A mapping of tags to assign to the resource. | <pre>object({<br/>    name     = string<br/>    location = string<br/>    tags     = map(string)<br/>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which to create the bastion host. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_semantic_search_sku"></a> [semantic\_search\_sku](#input\_semantic\_search\_sku) | (Optional) Specifies the Semantic Search SKU which should be used for this Search Service.<br/>Possible values include 'free' and 'standard'.<br/>NOTE:<br/>  The semantic\_search\_sku cannot be defined if your Search Services sku is set to 'free'.<br/>  The Semantic Search feature is only available in certain regions,<br/>  please see the product documentation for more information. | `string` | `null` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The pricing tier of the search service you want to create (for example, basic or standard). | `string` | `"standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(any)` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The endpoint used to connect to this Search Service. |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_primary_key"></a> [primary\_key](#output\_primary\_key) | The Primary Key used for Search Service Administration. |
| <a name="output_query_keys"></a> [query\_keys](#output\_query\_keys) | A list of query keys for the Search Service. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
| <a name="output_secondary_key"></a> [secondary\_key](#output\_secondary\_key) | The Secondary Key used for Search Service Administration. |
<!-- END_TF_DOCS -->
