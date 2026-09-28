## Example usage of the aks_backup_configuration module
module "aks_backup" {
  source = "../"

  aks = azurerm_kubernetes_cluster.example
  # aks = {
  #   id = module.AKS.id
  #   name = module.AKS.name
  #   principal_id = azurerm_user_assigned_identity.AKS.principal_id
  # }
  backup_vault    = azurerm_data_protection_backup_vault.example
  storage_account = azurerm_storage_account.example

  # storage_container_name       = "aks-backups"   ## Default: "backups-${var.aks.name}"
  # snapshot_resource_group_name = "rg-snapshots"  ## Default: "rg-snapshots-${var.aks.name}"
  # location                     = "uaenorth"      ## Default: var.backup_vault.location
  # tags                         = {}              ## Default: var.backup_vault.tags

  backup_repeating_time_intervals = ["R/2025-01-01T02:30:00+00:00/P1W"]

  included_namespaces = ["default"] ## Default: [] - all namespaces
  excluded_namespaces = []

  ## optional: retention_rules follows the schema expected by the provider
  retention_rules = [
    {
      name     = "Daily"
      priority = 25
      life_cycle = {
        duration        = "P30D"
        data_store_type = "OperationalStore"
      }
      criteria = {
        absolute_criteria = "FirstOfDay"
      }
    },
    {
      name     = "Weekly"
      priority = 20
      life_cycle = {
        duration        = "P90D"
        data_store_type = "OperationalStore"
      }
      criteria = {
        days_of_week           = ["Sunday"]
        months_of_year         = ["November"]
        weeks_of_month         = ["First"]
        scheduled_backup_times = ["2025-01-01T02:30:00Z"]
      }
    }
  ]
}
















###########################################################################
## Required providers (to pass TFLint checks)

terraform {
  required_version = ">= 1.9.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.10.0"
    }
  }
}
