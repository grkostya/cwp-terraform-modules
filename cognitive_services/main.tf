# Cognitive Speech (public access disable)
resource "azurerm_cognitive_account" "this" {
  name                = var.name
  location            = local.location
  resource_group_name = local.resource_group_name
  tags                = local.tags

  kind                       = var.kind
  sku_name                   = var.sku_name
  custom_subdomain_name      = var.custom_subdomain_name
  fqdns                      = var.fqdns
  dynamic_throttling_enabled = var.dynamic_throttling_enabled

  project_management_enabled = var.project_management_enabled

  local_auth_enabled                 = var.local_auth_enabled
  public_network_access_enabled      = var.public_network_access_enabled
  outbound_network_access_restricted = true

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "customer_managed_key" {
    for_each = var.customer_managed_key != null ? [var.customer_managed_key] : []

    content {
      key_vault_key_id   = customer_managed_key.value.key_vault_key_id
      identity_client_id = customer_managed_key.value.identity_client_id
    }
  }

  dynamic "network_acls" {
    for_each = var.network_acls != null ? var.network_acls : []

    content {
      bypass         = network_acls.value.bypass
      default_action = network_acls.value.default_action
      ip_rules       = network_acls.value.ip_rules

      dynamic "virtual_network_rules" {
        for_each = network_acls.value.virtual_network_rules != null ? network_acls.value.virtual_network_rules : []

        content {
          subnet_id                            = virtual_network_rules.value.subnet_id
          ignore_missing_vnet_service_endpoint = virtual_network_rules.value.ignore_missing_vnet_service_endpoint
        }
      }
    }
  }

  dynamic "storage" {
    for_each = var.storage != null ? [var.storage] : []

    content {
      storage_account_id = storage.value.storage_account_id
      identity_client_id = storage.value.identity_client_id
    }
  }

  dynamic "network_injection" {
    for_each = var.kind == "AIServices" && var.network_injection != null ? [var.network_injection] : []

    content {
      scenario  = "agent" ## The only supported scenario is "agent" for now
      subnet_id = network_injection.value.subnet_id
    }
  }
}
