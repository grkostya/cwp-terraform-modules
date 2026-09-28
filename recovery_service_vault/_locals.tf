
locals {
  resource_group_name = coalesce(var.resource_group_name, try(var.resource_group.name, null))

  location = coalesce(var.location, try(var.resource_group.location, null))

  identity_type = length(var.identity.ids) == 0 ? "SystemAssigned" : coalesce(var.identity.type, "SystemAssigned, UserAssigned")

  use_system_assigned_identity_for_encryption = var.encryption.user_assigned_identity_id == null ? true : false
}
