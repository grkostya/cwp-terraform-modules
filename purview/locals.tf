locals {
  resource_group_name = coalesce(var.resource_group_name, try(var.resource_group.name, null))
  location            = coalesce(var.location, try(var.resource_group.location, null))

  identity_type = var.user_assigned_identity_id == null ? "SystemAssigned" : "UserAssigned"
  identity_ids  = var.user_assigned_identity_id == null ? [] : [var.user_assigned_identity_id]
}
