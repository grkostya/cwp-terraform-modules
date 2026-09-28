# CMK Encryption using FristPartyIdentity
resource "azurerm_role_assignment" "CosmosDB_Encryption_User" {
  count = (var.default_identity_type == "FirstPartyIdentity") ? 1 : 0

  scope                = var.encryption_key.key_vault_id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = var.AzureCosmosDB_oid
}
