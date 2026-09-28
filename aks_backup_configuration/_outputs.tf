output "backup_policy_id" {
  description = "ID of the Data Protection backup policy created (if any)."
  value       = azurerm_data_protection_backup_policy_kubernetes_cluster.this.id
}


output "backup_instance_id" {
  description = "ID of the Data Protection backup instance created (if any)."
  value       = azurerm_data_protection_backup_instance_kubernetes_cluster.this.id
}


output "role_assignment_ids" {
  description = "List of role assignment IDs created by the module."
  value = compact([
    try(azurerm_role_assignment.Storage_Account_Contributor_for_extension.id, ""),
    try(azurerm_role_assignment.Reader_on_AKS_cluster_for_backup_vault.id, ""),
    try(azurerm_role_assignment.Reader_on_snapshot_resource_group_for_backup_vault.id, ""),
    try(azurerm_role_assignment.Disk_Snapshot_Contributor.id, ""),
    try(azurerm_role_assignment.Data_Operator_for_Managed_Disks.id, ""),
    try(azurerm_role_assignment.Contributor_on_snapshot_resource_group_for_AKS_identity.id, ""),
    # try(azurerm_role_assignment.Storage_Blob_Data_Contributor_for_backup_vault.id, ""),
  ])
}
