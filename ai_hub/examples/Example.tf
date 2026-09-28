module "AI_Foundry" {
  source             = "../../../modules/ai_hub"
  name_suffix        = "<module.naming.name_suffix>"
  resource_group     = azurerm_resource_group.this
  storage_account_id = module.Storage_Account.id
  key_vault_id       = module.Key_Vault.id

  ## Encryption
  cmk_keyvault_key_uri      = azurerm_key_vault_key.Encryption.id ## The key version is required
  cmk_client_id             = azurerm_user_assigned_identity.Encryption.client_id
  user_assigned_identity_id = azurerm_user_assigned_identity.Encryption.id
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
