resource "azurerm_key_vault" "this" {
  name                          = local.key_vault_name
  location                      = local.location
  resource_group_name           = local.resource_group_name
  enabled_for_disk_encryption   = true
  tenant_id                     = local.tenant_id
  soft_delete_retention_days    = 90
  purge_protection_enabled      = var.purge_protection_enabled
  sku_name                      = "standard"
  rbac_authorization_enabled    = true
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = local.tags

  network_acls {
    bypass                     = var.network_acls.bypass
    default_action             = var.network_acls.default_action
    ip_rules                   = var.network_acls.ip_rules
    virtual_network_subnet_ids = var.network_acls.virtual_network_subnet_ids
  }

  ## lifecycle {
  ##   ignore_changes = [network_acls.ip_rules]
  ## }

  ## Deprecated
  # enable_rbac_authorization = true  ## renamed to 'rbac_authorization_enabled'
}
