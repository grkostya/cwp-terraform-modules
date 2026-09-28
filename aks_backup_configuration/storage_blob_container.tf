resource "azurerm_storage_container" "backups" {
  name                  = local.storage_container_name
  storage_account_id    = var.storage_account.id
  container_access_type = "private"
}
