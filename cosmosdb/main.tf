resource "azurerm_cosmosdb_account" "this" {
  # depends_on = [azurerm_role_assignment.CosmosDB_Encryption_User]

  name                = var.name
  location            = local.location
  resource_group_name = local.resource_group_name
  offer_type          = "Standard"
  kind                = var.kind                                  ## Default: "GlobalDocumentDB"
  tags                = merge(local.tags, local.CMK_Identity_Tag) ## To set up a dependency on a role assignment when using CMK encryption

  # Consistency policy for SQL API
  consistency_policy {
    consistency_level       = var.consistency_policy.consistency_level       ## Default: "BoundedStaleness"
    max_interval_in_seconds = var.consistency_policy.max_interval_in_seconds ## Default: 300
    max_staleness_prefix    = var.consistency_policy.max_staleness_prefix    ## Default: 100000
  }

  # Automatic failover and multi-region setup
  automatic_failover_enabled = var.automatic_failover_enabled ## Default: false

  # Single region setup
  geo_location {
    location          = local.location
    failover_priority = 0
  }

  ## CMK Encryption
  key_vault_key_id = var.encryption_key.versionless_id

  ## Required to enable Continuous backup while using CMK encryption
  default_identity_type = local.default_identity_type
  identity {
    type         = local.identity_type
    identity_ids = local.identity_ids
  }

  backup {
    type = var.backup.type ## Default: "Continuous"
    tier = var.backup.tier ## Default "Continuous7Days"
  }

  public_network_access_enabled = var.public_network_access_enabled ## Default: false
  local_authentication_disabled = var.local_authentication_disabled ## Default: false

  dynamic "capabilities" {
    for_each = var.capabilities
    content {
      name = capabilities.value.name
    }
  }

  # ## TEMP
  # is_virtual_network_filter_enabled = true
  # ip_range_filter                   = local.ip_ranges
  # virtual_network_rule {
  #   id                                   = data.azurerm_subnet.default.id
  #   ignore_missing_vnet_service_endpoint = false
  # }

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      analytical_storage, # optional — if you don’t want small feature toggles to force recreation
    ]
  }
  mongo_server_version = var.mongo_server_version
}
