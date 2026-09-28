locals {
  location = coalesce(var.location, try(var.backup_vault.location, null))

  storage_container_name = coalesce(var.storage_container_name, "backups-${var.aks.name}")

  aks_cluster_principal_id  = coalesce(var.aks.principal_id, try(var.aks.identity[0].principal_id, null))
  backup_vault_principal_id = coalesce(var.backup_vault.principal_id, try(var.backup_vault.identity[0].principal_id, null))

  snapshot_resource_group_name = coalesce(var.snapshot_resource_group_name, "rg-snapshots-${var.aks.name}")

  backup_policy_name   = var.aks.name
  backup_instance_name = var.aks.name
}
