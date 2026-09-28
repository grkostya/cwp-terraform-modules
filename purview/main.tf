resource "azurerm_purview_account" "this" {
  name                = var.name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

  identity {
    type         = local.identity_type
    identity_ids = local.identity_ids
  }

  public_network_enabled = var.public_network_access_enabled

  managed_resource_group_name = "managed-rg-${var.name}"
}
