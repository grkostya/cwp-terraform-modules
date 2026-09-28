resource "azurerm_cosmosdb_mongo_database" "this" {
  count = var.create_mongodb_database ? 1 : 0

  name                = var.mongodb_database_name
  resource_group_name = azurerm_cosmosdb_account.this.resource_group_name
  account_name        = azurerm_cosmosdb_account.this.name
  throughput          = var.database_throughput
}




resource "azurerm_cosmosdb_mongo_collection" "this" {
  for_each = { for collection in var.mongodb_collections : collection.name => collection }

  name                = each.value.name
  resource_group_name = azurerm_cosmosdb_account.this.resource_group_name
  account_name        = azurerm_cosmosdb_account.this.name
  database_name       = azurerm_cosmosdb_mongo_database.this[0].name

  default_ttl_seconds = each.value.default_ttl_seconds
  shard_key           = each.value.shard_key
  throughput          = each.value.throughput

  dynamic "index" {
    for_each = each.value.index
    content {
      keys   = index.value.keys
      unique = index.value.unique
    }
  }
}
