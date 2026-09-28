###########################################################################
## Diagnostic Settings

locals {
  diagnostic_setting_enabled = var.diagnostic_setting_enabled && var.oms_agent != null ? true : false
}

resource "azurerm_monitor_diagnostic_setting" "AKS" {
  count = local.diagnostic_setting_enabled ? 1 : 0

  name                           = "allLogs"
  target_resource_id             = azurerm_kubernetes_cluster.this.id
  log_analytics_workspace_id     = var.oms_agent.log_analytics_workspace_id
  log_analytics_destination_type = "Dedicated"

  enabled_log {
    category_group = "allLogs"
  }

  # enabled_log {
  #   category_group = "audit"
  # }

  enabled_metric {
    category = "AllMetrics"
  }
}
