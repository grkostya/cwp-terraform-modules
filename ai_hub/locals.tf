locals {
  resource_group_name = coalesce(var.resource_group_name, try(var.resource_group.name, null))

  resource_group_id = coalesce(var.resource_group_id, try(var.resource_group.id, null))

  location = coalesce(var.location, try(var.resource_group.location, null))

  tags = coalesce(var.tags, try(var.resource_group.tags, null))

  ai_services_connection_name = "Default_AIServices" ## ^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$ ## 3-33

  ## Indicates whether or not the encryption is enabled for the workspace.
  hub_encryption_status = var.cmk_keyvault_key_uri == null ? "Disabled" : "Enabled"

  user_assigned_identity_ids = var.user_assigned_identity_id == null ? [] : [var.user_assigned_identity_id]

  # ai_project_name = substr("aiprj-${replace(var.name_suffix, "-", "")}", 0, 33) ## ^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$ ## 3-33
}
