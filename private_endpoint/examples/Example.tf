
module "Private_Endpoint_Key_Vault" {
  source = "../../../modules/private_endpoint"

  resource_group              = azurerm_resource_group.this
  private_connection_resource = azurerm_key_vault.this
  subresource_names           = ["vault"]
  subnet_id                   = data.azurerm_subnet.default.id
  private_dns_zone_ids        = [data.azurerm_private_dns_zone.Key_Vault.id]
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
