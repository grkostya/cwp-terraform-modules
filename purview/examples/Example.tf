module "Purview" {
  source         = "../../../modules/purview"
  name           = module.naming.custom.purview_account.name
  resource_group = azurerm_resource_group.this

  # user_assigned_identity_id = azurerm_user_assigned_identity.Purview.id
}


module "Private_Endpoint_Purview_Account" {
  source = "../../../modules/private_endpoint"

  resource_group              = azurerm_resource_group.this
  private_connection_resource = module.Purview
  subresource_names           = ["account"]
  subnet_id                   = data.azurerm_subnet.Private_Endpoints.id
  private_dns_zone_ids        = [data.azurerm_private_dns_zone.Purview.id]
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
