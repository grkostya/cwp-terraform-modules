resource "azurerm_search_service" "this" {
  name                = var.name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

  sku             = var.sku
  replica_count   = var.replica_count
  partition_count = var.partition_count

  public_network_access_enabled = var.public_network_access_enabled
  allowed_ips                   = var.allowed_ips

  local_authentication_enabled = var.local_authentication_enabled
  authentication_failure_mode  = "http401WithBearerChallenge"

  semantic_search_sku = var.semantic_search_sku
}
