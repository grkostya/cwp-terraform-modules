## Backup policy for Kubernetes cluster
resource "azurerm_data_protection_backup_policy_kubernetes_cluster" "this" {
  name                = local.backup_policy_name
  resource_group_name = var.backup_vault.resource_group_name
  vault_name          = var.backup_vault.name

  backup_repeating_time_intervals = var.backup_repeating_time_intervals

  dynamic "retention_rule" {
    for_each = var.retention_rules
    content {
      name     = retention_rule.value.name
      priority = lookup(retention_rule.value, "priority", 100)

      life_cycle {
        duration        = retention_rule.value.life_cycle.duration
        data_store_type = retention_rule.value.life_cycle.data_store_type
      }

      criteria {
        absolute_criteria      = retention_rule.value.criteria.absolute_criteria
        days_of_week           = retention_rule.value.criteria.days_of_week
        months_of_year         = retention_rule.value.criteria.months_of_year
        weeks_of_month         = retention_rule.value.criteria.weeks_of_month
        scheduled_backup_times = retention_rule.value.criteria.scheduled_backup_times
      }
    }
  }

  default_retention_rule {
    life_cycle {
      duration        = var.default_retention_life_cycle.duration
      data_store_type = var.default_retention_life_cycle.data_store_type
    }
  }
}


## Backup instance for the AKS cluster
resource "azurerm_data_protection_backup_instance_kubernetes_cluster" "this" {
  name                         = local.backup_instance_name
  location                     = local.location
  vault_id                     = var.backup_vault.id
  kubernetes_cluster_id        = var.aks.id
  snapshot_resource_group_name = local.snapshot_resource_group_name
  backup_policy_id             = azurerm_data_protection_backup_policy_kubernetes_cluster.this.id

  backup_datasource_parameters {
    excluded_namespaces              = var.excluded_namespaces
    excluded_resource_types          = var.excluded_resource_types
    cluster_scoped_resources_enabled = var.cluster_scoped_resources_enabled
    included_namespaces              = var.included_namespaces
    included_resource_types          = var.included_resource_types
    label_selectors                  = var.label_selectors
    volume_snapshot_enabled          = var.volume_snapshot_enabled
  }

  depends_on = [
    azurerm_role_assignment.Storage_Account_Contributor_for_extension,
    azurerm_role_assignment.Reader_on_AKS_cluster_for_backup_vault,
    azurerm_role_assignment.Reader_on_snapshot_resource_group_for_backup_vault,
    azurerm_role_assignment.Contributor_on_snapshot_resource_group_for_AKS_identity,
    azurerm_role_assignment.Disk_Snapshot_Contributor,
    azurerm_role_assignment.Data_Operator_for_Managed_Disks,
    # azurerm_role_assignment.Storage_Blob_Data_Contributor_for_backup_vault,
  ]
}
