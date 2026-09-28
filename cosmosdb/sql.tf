resource "azurerm_cosmosdb_sql_database" "this" {
  count = var.create_sql_database ? 1 : 0

  name                = var.sql_database_name
  resource_group_name = azurerm_cosmosdb_account.this.resource_group_name
  account_name        = azurerm_cosmosdb_account.this.name
  throughput          = var.database_throughput
  lifecycle {
    prevent_destroy = true
  }
}




resource "azurerm_cosmosdb_sql_container" "this" {
  for_each = var.sql_database_containers

  name                  = each.key
  resource_group_name   = azurerm_cosmosdb_account.this.resource_group_name
  account_name          = azurerm_cosmosdb_account.this.name
  database_name         = azurerm_cosmosdb_sql_database.this[0].name
  partition_key_paths   = each.value.partition_key_paths ## Default: ["/id"]
  partition_key_version = 2                              ## 2 - Large Partition Key
  throughput            = each.value.throughput          ## Default: 400

  indexing_policy {
    indexing_mode = "consistent"

    included_path {
      path = "/*"
    }
  }

  conflict_resolution_policy {
    conflict_resolution_path = "/_ts"
    mode                     = "LastWriterWins"
  }
  lifecycle {
    prevent_destroy = true
  }
}
