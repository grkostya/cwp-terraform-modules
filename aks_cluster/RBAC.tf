# ###########################################################################
# ### RBAC

locals {
  aks_identity_principal_id = coalesce(azurerm_kubernetes_cluster.this.identity[0].principal_id, data.azurerm_user_assigned_identity.cluster_identity[0].principal_id)
}


resource "azurerm_role_assignment" "AKS_Read_diskEncryptionSets" {
  # count = var.disk_encryption_set_id == null ? 0 : 1

  scope                = var.disk_encryption_set_id
  role_definition_name = "Defender Agentless VM Scan" ## "VM Scanner Operator" # Required permission: "Microsoft.Compute/diskEncryptionSets/read"
  principal_id         = local.aks_identity_principal_id
}
