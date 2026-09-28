<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >=0.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.0 |
| <a name="provider_time"></a> [time](#provider\_time) | >=0.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_data_protection_backup_instance_kubernetes_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_protection_backup_instance_kubernetes_cluster) | resource |
| [azurerm_data_protection_backup_policy_kubernetes_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_protection_backup_policy_kubernetes_cluster) | resource |
| [azurerm_kubernetes_cluster_extension.backup](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_extension) | resource |
| [azurerm_kubernetes_cluster_trusted_access_role_binding.aks_cluster_trusted_access](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_trusted_access_role_binding) | resource |
| [azurerm_resource_group.snapshots](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.Contributor_on_snapshot_resource_group_for_AKS_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.Data_Operator_for_Managed_Disks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.Disk_Snapshot_Contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.Reader_on_AKS_cluster_for_backup_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.Reader_on_snapshot_resource_group_for_backup_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.Storage_Account_Contributor_for_extension](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.Storage_Blob_Data_Contributor_for_extension](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_container.backups](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [time_static.now](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks"></a> [aks](#input\_aks) | Object containing AKS cluster information. Provide all properties when you want the module to configure role<br/>assignments and backup instance for an existing AKS cluster.<br/><br/>  id                     = Resource ID of the AKS cluster (example = azurerm\_kubernetes\_cluster.example.id)<br/>  name                   = Name of the AKS cluster<br/>  principal\_id           = Principal ID (object id) of the AKS cluster managed identity (identity[0].principal\_id) | <pre>object({<br/>    id           = string<br/>    name         = string<br/>    principal_id = optional(string, null)<br/>    identity = optional(list(object({<br/>      principal_id = string<br/>    })), null)<br/>  })</pre> | n/a | yes |
| <a name="input_backup_repeating_time_intervals"></a> [backup\_repeating\_time\_intervals](#input\_backup\_repeating\_time\_intervals) | List of ISO8601 repeating time intervals for backups (e.g. ["R/2023-05-23T02:30:00+00:00/P1W"]). | `list(string)` | `[]` | no |
| <a name="input_backup_vault"></a> [backup\_vault](#input\_backup\_vault) | Object containing Backup Vault information (provide all properties when the vault exists):<br/><br/>  id                  = Resource ID of the Data Protection Backup Vault (example = azurerm\_data\_protection\_backup\_vault.example.id)<br/>  name                = Name of the Backup Vault (used when creating policies)<br/>  resource\_group\_name = Name of the resource group where the Backup Vault exists<br/>  principal\_id        = Principal ID (object id) of the Backup Vault managed identity (identity[0].principal\_id) | <pre>object({<br/>    id                  = string<br/>    name                = string<br/>    location            = string<br/>    resource_group_name = string<br/>    principal_id        = optional(string, null)<br/>    tags                = map(any)<br/>    identity = optional(list(object({<br/>      principal_id = string<br/>    })), null)<br/>  })</pre> | n/a | yes |
| <a name="input_cluster_scoped_resources_enabled"></a> [cluster\_scoped\_resources\_enabled](#input\_cluster\_scoped\_resources\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_default_retention_life_cycle"></a> [default\_retention\_life\_cycle](#input\_default\_retention\_life\_cycle) | Map containing default retention life\_cycle information. Provide all properties to configure the default retention settings for backups.<br/><br/>  duration        = ISO8601 duration string for the retention period (example = "P14D" for 14 days)<br/>  data\_store\_type = Type of data store for retention (example = "OperationalStore") | `any` | <pre>{<br/>  "data_store_type": "OperationalStore",<br/>  "duration": "P14D"<br/>}</pre> | no |
| <a name="input_excluded_namespaces"></a> [excluded\_namespaces](#input\_excluded\_namespaces) | n/a | `list(string)` | `[]` | no |
| <a name="input_excluded_resource_types"></a> [excluded\_resource\_types](#input\_excluded\_resource\_types) | n/a | `list(string)` | `[]` | no |
| <a name="input_included_namespaces"></a> [included\_namespaces](#input\_included\_namespaces) | n/a | `list(string)` | `[]` | no |
| <a name="input_included_resource_types"></a> [included\_resource\_types](#input\_included\_resource\_types) | n/a | `list(string)` | `[]` | no |
| <a name="input_label_selectors"></a> [label\_selectors](#input\_label\_selectors) | n/a | `list(string)` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure location for the backup instance. | `string` | `""` | no |
| <a name="input_retention_rules"></a> [retention\_rules](#input\_retention\_rules) | List of retention rule objects matching the backup policy retention\_rule blocks<br/><br/>  name       = Name of the retention rule<br/>  priority   = (Optional) Priority of the retention rule (default = 100)<br/>  life\_cycle = Map containing life\_cycle information:<br/>    duration        = ISO8601 duration string for the retention period (example = "P14D" for 14 days)<br/>    data\_store\_type = Type of data store for retention (example = "OperationalStore")<br/>  criteria = (Optional) Map containing criteria information:<br/>    absolute\_criteria      = (Optional) Possible values are 'AllBackup', 'FirstOfDay', 'FirstOfWeek',<br/>                             'FirstOfMonth' and 'FirstOfYear'. These values mean the first successful<br/>                             backup of the day/week/month/year. Changing this forces a new resource to be created.<br/>    days\_of\_week           = (Optional) List of days of the week for retention (example = ["Sunday"])<br/>    months\_of\_year         = (Optional) List of months of the year for retention (example = ["November"])<br/>    weeks\_of\_month         = (Optional) Possible values are 'First', 'Second', 'Third', 'Fourth' and<br/>                             'Last'. Changing this forces a new resource to be created.<br/>                             (example = ["First"])<br/>    scheduled\_backup\_times = (Optional) Specifies a list of backup times for retention in the RFC3339 format.<br/>                             (example = ["2023-05-23T02:30:00Z"])<br/><br/>Note:<br/>  When not using 'absolute\_criteria', you must use exactly one of 'days\_of\_month' or 'days\_of\_week'.<br/>  Regarding the remaining two properties, 'weeks\_of\_month' and 'months\_of\_year', you may use either,<br/>  both, or neither. If you would like to set multiple intervals, you may do so by using<br/>  multiple 'retention\_rule' blocks. | <pre>list(object({<br/>    name     = string<br/>    priority = optional(number, 100)<br/>    life_cycle = object({<br/>      duration        = string<br/>      data_store_type = optional(string, "OperationalStore")<br/>    })<br/>    criteria = optional(object({<br/>      absolute_criteria      = optional(string, null)<br/>      days_of_week           = optional(list(string), null)<br/>      months_of_year         = optional(list(string), null)<br/>      weeks_of_month         = optional(list(string), null)<br/>      scheduled_backup_times = optional(list(string), null)<br/>    }), {})<br/>  }))</pre> | `[]` | no |
| <a name="input_snapshot_resource_group_name"></a> [snapshot\_resource\_group\_name](#input\_snapshot\_resource\_group\_name) | Name of the resource group to use for snapshot resources. | `string` | `null` | no |
| <a name="input_storage_account"></a> [storage\_account](#input\_storage\_account) | Object containing Storage Account information (provide all properties when the account exists):<br/><br/>  id                  = Resource ID of the storage account used for backups (example = azurerm\_storage\_account.example.id)<br/>  name                = Name of the storage account<br/>  resource\_group\_name = Name of the resource group where the storage account exists | <pre>object({<br/>    id                  = string<br/>    name                = string<br/>    resource_group_name = string<br/>  })</pre> | n/a | yes |
| <a name="input_storage_container_name"></a> [storage\_container\_name](#input\_storage\_container\_name) | Name of the storage container used for backups. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(any)` | `null` | no |
| <a name="input_volume_snapshot_enabled"></a> [volume\_snapshot\_enabled](#input\_volume\_snapshot\_enabled) | n/a | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backup_instance_id"></a> [backup\_instance\_id](#output\_backup\_instance\_id) | ID of the Data Protection backup instance created (if any). |
| <a name="output_backup_policy_id"></a> [backup\_policy\_id](#output\_backup\_policy\_id) | ID of the Data Protection backup policy created (if any). |
| <a name="output_role_assignment_ids"></a> [role\_assignment\_ids](#output\_role\_assignment\_ids) | List of role assignment IDs created by the module. |
<!-- END_TF_DOCS -->
