
resource "azurerm_storage_account" "this" {
  name                     = local.name
  resource_group_name      = local.resource_group_name
  location                 = local.location
  account_tier             = var.account_tier
  account_kind             = var.account_kind
  account_replication_type = var.account_replication_type

  shared_access_key_enabled     = var.shared_access_key_enabled
  public_network_access_enabled = var.public_network_access_enabled

  is_hns_enabled = var.is_hns_enabled
  nfsv3_enabled  = var.nfsv3_enabled

  allow_nested_items_to_be_public  = var.allow_nested_items_to_be_public
  cross_tenant_replication_enabled = var.cross_tenant_replication_enabled
  default_to_oauth_authentication  = var.default_to_oauth_authentication
  allowed_copy_scope               = var.allowed_copy_scope


  blob_properties {
    delete_retention_policy {
      days = var.blob_delete_retention_policy_days
    }
    container_delete_retention_policy {
      days = var.blob_container_delete_retention_policy_days
    }
    dynamic "cors_rule" {
      for_each = var.blob_cors_rule
      content {
        allowed_headers    = cors_rule.value.allowed_headers
        allowed_methods    = cors_rule.value.allowed_methods
        allowed_origins    = cors_rule.value.allowed_origins
        exposed_headers    = cors_rule.value.exposed_headers
        max_age_in_seconds = cors_rule.value.max_age_in_seconds
      }
    }
  }

  network_rules {
    default_action             = var.network_rules.default_action
    ip_rules                   = var.network_rules.ip_rules
    virtual_network_subnet_ids = var.network_rules.virtual_network_subnet_ids
    bypass                     = var.network_rules.bypass
  }


  dynamic "identity" {
    for_each = local.identity == null ? [] : [1]
    content {
      type         = local.identity.type
      identity_ids = local.identity.identity_ids
    }
  }

  # Encryption
  dynamic "customer_managed_key" {
    for_each = try(var.customer_managed_key.key_vault_key_id, null) == null ? [] : ["key_vault_key_id"]
    content {
      user_assigned_identity_id = var.customer_managed_key.user_assigned_identity_id
      key_vault_key_id          = var.customer_managed_key.key_vault_key_id
    }
  }
  dynamic "customer_managed_key" {
    for_each = try(var.customer_managed_key.managed_hsm_key_id, null) == null ? [] : ["managed_hsm_key_id"]
    content {
      user_assigned_identity_id = var.customer_managed_key.user_assigned_identity_id
      managed_hsm_key_id        = var.customer_managed_key.managed_hsm_key_id
    }
  }
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled

  queue_encryption_key_type = var.queue_encryption_key_type ## Set "Account" to enable CMK for queue encryption. Default: "Account" (Originally "Service")
  table_encryption_key_type = var.table_encryption_key_type ## Set "Account" to enable CMK for table encryption. Default: "Account" (Originally "Service")

  tags = local.tags

  lifecycle {
    ignore_changes = [network_rules]
  }
}


resource "azurerm_storage_container" "Containers" {
  for_each = toset(var.storage_containers)
  name     = each.value

  storage_account_id = azurerm_storage_account.this.id
}

resource "azurerm_storage_account_static_website" "this" {
  count = var.enable_static_website ? 1 : 0

  storage_account_id = azurerm_storage_account.this.id
  error_404_document = var.static_error_404_document
  index_document     = var.static_index_document
}
