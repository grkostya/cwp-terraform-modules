resource "azurerm_recovery_services_vault" "this" {
  name                = var.name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

  sku                           = var.sku
  soft_delete_enabled           = var.soft_delete_enabled
  public_network_access_enabled = var.public_network_access_enabled
  storage_mode_type             = var.storage_mode_type
  cross_region_restore_enabled  = var.cross_region_restore_enabled
  immutability                  = var.immutability

  identity {
    type         = local.identity_type
    identity_ids = var.identity.ids
  }

  dynamic "encryption" {
    for_each = var.encryption.key_id == null ? [] : [var.encryption]

    content {
      infrastructure_encryption_enabled = encryption.value.infrastructure_encryption_enabled
      key_id                            = encryption.value.key_id
      use_system_assigned_identity      = local.use_system_assigned_identity_for_encryption
      user_assigned_identity_id         = encryption.value.user_assigned_identity_id
    }
  }

  #   monitoring {
  #     alerts_for_all_job_failures_enabled            = var.monitoring.alerts_for_all_job_failures_enabled
  #     alerts_for_critical_operation_failures_enabled = var.monitoring.alerts_for_critical_operation_failures_enabled
  #   }
}
