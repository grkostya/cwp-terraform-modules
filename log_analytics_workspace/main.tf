## Log Analytics Workspace

resource "azurerm_log_analytics_workspace" "this" {
  name                       = var.name
  resource_group_name        = local.resource_group_name
  location                   = local.location
  tags                       = local.tags
  internet_ingestion_enabled = var.internet_ingestion_enabled
  internet_query_enabled     = var.internet_query_enabled
  sku                        = var.sku
  retention_in_days          = var.retention_in_days
}
