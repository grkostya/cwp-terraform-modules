resource "azurerm_machine_learning_workspace" "this" {
  name                = var.name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

  application_insights_id = var.application_insights_id
  container_registry_id   = var.container_registry_id
  key_vault_id            = var.key_vault_id
  storage_account_id      = var.storage_account_id

  public_network_access_enabled = var.public_network_access_enabled
  high_business_impact          = var.high_business_impact
  v1_legacy_mode_enabled        = var.legacy_mode_enabled
  image_build_compute_name      = var.image_build_compute_name

  serverless_compute {
    subnet_id = var.serverless_compute_subnet_id
  }

  primary_user_assigned_identity = tolist(var.identity.identity_ids)[0]
  identity {
    type         = var.identity.type
    identity_ids = var.identity.identity_ids
  }

  service_side_encryption_enabled = true
  dynamic "encryption" {
    for_each = try(var.customer_managed_key.key_vault_key_id, null) == null ? [] : ["key_vault_key_id"]
    content {
      user_assigned_identity_id = var.customer_managed_key.user_assigned_identity_id
      key_vault_id              = var.customer_managed_key.key_vault_id
      key_id                    = var.customer_managed_key.key_vault_key_id
    }
  }
}
