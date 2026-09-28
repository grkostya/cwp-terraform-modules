locals {
  env                  = terraform.workspace
  storage_account_name = "sa${local.env}basic"
}


data "azurerm_resource_group" "Main" {
  name = "resource-group-name"
}


module "Storage_Account" {
  source = "../../../modules/storage_account"

  name           = local.storage_account_name
  resource_group = data.azurerm_resource_group.Main

  ## Uncomment to override the values from the 'data.azurerm_resource_group.Main' object:
  # resource_group_name = data.azurerm_resource_group.Main.name
  # location            = "eastus2"
  # tags                = var.tags

  shared_access_key_enabled     = true
  public_network_access_enabled = true
}
