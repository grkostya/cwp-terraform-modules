module "Recovery_Service_Vault" {
  source = "../../../modules/recovery_service_vault"

  name           = module.NAMING.azure.recovery_services_vault.name
  resource_group = azurerm_resource_group.this
  tags           = {}

  storage_mode_type = "ZoneRedundant" ## Default: "GeoRedundant"


  identity = { ids = [azurerm_user_assigned_identity.Encryption.id] }

  encryption = {
    # infrastructure_encryption_enabled = false  ## Default: true
    key_id                    = azurerm_key_vault_key.Encryption.id
    user_assigned_identity_id = azurerm_user_assigned_identity.Encryption.id
  }

  #   sku                           = "RS0"       ## Default: "Standard"
  #   soft_delete_enabled           = false       ## Default: true
  #   public_network_access_enabled = true        ## Default: false
  #   cross_region_restore_enabled  = true        ## Default: false
  #   immutability                  = "Unlocked"  ## Default: "Disabled"

  #   monitoring = {
  #     alerts_for_all_job_failures_enabled            = false  ## Default: true
  #     alerts_for_critical_operation_failures_enabled = false  ## Default: true
  #   }
}
















###########################################################################
## Required providers (to pass TFLint checks)

terraform {
  required_version = ">= 1.9.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.10.0"
    }
  }
}
