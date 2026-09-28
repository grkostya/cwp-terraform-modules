resource "azurerm_container_registry" "this" {
  name                          = var.name
  resource_group_name           = local.resource_group_name
  location                      = local.location
  sku                           = var.sku
  admin_enabled                 = var.admin_enabled
  tags                          = local.tags
  public_network_access_enabled = var.public_network_access_enabled
  export_policy_enabled         = var.export_policy_enabled
  anonymous_pull_enabled        = var.anonymous_pull_enabled
  zone_redundancy_enabled       = var.zone_redundancy_enabled
  retention_policy_in_days      = var.sku == "Basic" ? null : var.retention_policy_in_days

  dynamic "identity" {
    for_each = var.identity == null ? [] : ["identity"]
    content {
      type         = var.identity.type
      identity_ids = var.identity.identity_ids
    }
  }
  dynamic "encryption" {
    for_each = try(var.customer_managed_key.key_vault_key_id, null) == null ? [] : ["key_vault_key_id"]
    content {
      key_vault_key_id   = var.customer_managed_key.key_vault_key_id
      identity_client_id = var.customer_managed_key.user_assigned_identity_client_id
    }
  }
}
