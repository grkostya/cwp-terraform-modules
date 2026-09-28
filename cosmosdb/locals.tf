locals {
  resource_group_name = coalesce(var.resource_group_name, try(var.resource_group.name, null))
  location            = coalesce(var.location, try(var.resource_group.location, null))

  default_identity_type = var.user_assigned_identity_id == null ? var.default_identity_type : "UserAssignedIdentity=${var.user_assigned_identity_id}"
  identity_type         = var.user_assigned_identity_id == null ? "SystemAssigned" : "SystemAssigned, UserAssigned"
  identity_ids          = var.user_assigned_identity_id == null ? [] : [var.user_assigned_identity_id]

  CMK_Identity_Tag = (var.encryption_key.key_vault_id == null && var.default_identity_type != "FirstPartyIdentity") ? {} : { EncryptionID_RBAC_Assignment = try(azurerm_role_assignment.CosmosDB_Encryption_User[0].id, null) }
}
