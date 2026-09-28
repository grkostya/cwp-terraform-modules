resource "azurerm_maps_account" "this" {
  name                         = var.name
  resource_group_name          = local.resource_group_name
  location                     = local.location
  sku_name                     = var.sku_name
  tags                         = local.tags
  local_authentication_enabled = var.local_authentication_enabled

  dynamic "cors" {
    for_each = var.cors
    content {
      allowed_origins = cors.value.allowed_origins
    }
  }

  dynamic "data_store" {
    for_each = var.data_store
    content {
      storage_account_id = data_store.value.storage_account_id
      unique_name        = data_store.value.unique_name
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }
}
