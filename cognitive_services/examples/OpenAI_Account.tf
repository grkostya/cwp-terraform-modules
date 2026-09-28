module "OpenAI" {
  source = "../../../modules/cognitive_services"

  resource_group        = azurerm_resource_group.this
  name                  = module.NAMING.custom.openai_account.name
  custom_subdomain_name = module.NAMING.custom.openai_account.name
  kind                  = "OpenAI"
  sku_name              = "S0"

  identity = {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.Encryption.id]
  }

  ## Encryption
  customer_managed_key = {
    identity_client_id = azurerm_user_assigned_identity.Encryption.client_id
    key_vault_key_id   = azurerm_key_vault_key.Encryption.id
  }

  network_acls = [{
    # bypass         = "AzureServices"
    default_action = "Deny"
  }]

  ## Key authentication
  local_auth_enabled = true ## Default: false
}


module "Private_Endpoint_OpenAI_Account" {
  source = "../../../modules/private_endpoint"

  resource_group              = azurerm_resource_group.this
  private_connection_resource = module.OpenAI
  subresource_names           = ["account"]
  subnet_id                   = module.DATA.subnet["Private-Endpoints"].id
  private_dns_zone_ids        = [module.DATA.private_dns_zone["privatelink.openai.azure.com"].id]
}
