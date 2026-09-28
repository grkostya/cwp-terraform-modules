resource "azurerm_kubernetes_cluster_extension" "backup" {
  name              = "azure-aks-backup"
  cluster_id        = var.aks.id
  extension_type    = "microsoft.dataprotection.kubernetes"
  release_train     = "Stable"
  release_namespace = "kube-system"
  configuration_settings = {
    "configuration.backupStorageLocation.bucket"                = azurerm_storage_container.backups.name
    "configuration.backupStorageLocation.config.resourceGroup"  = var.storage_account.resource_group_name
    "configuration.backupStorageLocation.config.storageAccount" = var.storage_account.name
    "configuration.backupStorageLocation.config.subscriptionId" = data.azurerm_client_config.current.subscription_id
    "credentials.tenantId"                                      = data.azurerm_client_config.current.tenant_id

    "configuration.backupStorageLocation.config.useAAD"            = true
    "configuration.backupStorageLocation.config.storageAccountURI" = try(var.storage_account.primary_blob_endpoint, "https://${var.storage_account.name}.blob.core.windows.net/")
  }
}


resource "azurerm_kubernetes_cluster_trusted_access_role_binding" "aks_cluster_trusted_access" {
  kubernetes_cluster_id = var.aks.id
  name                  = "backup-vault"
  roles                 = ["Microsoft.DataProtection/backupVaults/backup-operator"]
  source_resource_id    = var.backup_vault.id
}
