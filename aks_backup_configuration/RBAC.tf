resource "azurerm_role_assignment" "Storage_Account_Contributor_for_extension" {
  scope                = var.storage_account.id
  role_definition_name = "Storage Account Contributor"
  principal_id         = azurerm_kubernetes_cluster_extension.backup.aks_assigned_identity[0].principal_id
}


resource "azurerm_role_assignment" "Storage_Blob_Data_Contributor_for_extension" {
  scope                = var.storage_account.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_kubernetes_cluster_extension.backup.aks_assigned_identity[0].principal_id
}


resource "azurerm_role_assignment" "Reader_on_AKS_cluster_for_backup_vault" {
  scope                = var.aks.id
  role_definition_name = "Reader"
  principal_id         = local.backup_vault_principal_id
}


resource "azurerm_role_assignment" "Reader_on_snapshot_resource_group_for_backup_vault" {
  scope                = azurerm_resource_group.snapshots.id
  role_definition_name = "Reader"
  principal_id         = local.backup_vault_principal_id
}


resource "azurerm_role_assignment" "Disk_Snapshot_Contributor" {
  scope                = azurerm_resource_group.snapshots.id
  role_definition_name = "Disk Snapshot Contributor"
  principal_id         = local.backup_vault_principal_id
}


resource "azurerm_role_assignment" "Data_Operator_for_Managed_Disks" {
  scope                = azurerm_resource_group.snapshots.id
  role_definition_name = "Data Operator for Managed Disks"
  principal_id         = local.backup_vault_principal_id
}


# resource "azurerm_role_assignment" "Storage_Blob_Data_Contributor_for_backup_vault" {
#   scope                = var.storage_account.id
#   role_definition_name = "Storage Blob Data Contributor"
#   principal_id         = local.backup_vault_principal_id
# }


resource "azurerm_role_assignment" "Contributor_on_snapshot_resource_group_for_AKS_identity" {
  scope                = azurerm_resource_group.snapshots.id
  role_definition_name = "Contributor"
  principal_id         = local.aks_cluster_principal_id
}
