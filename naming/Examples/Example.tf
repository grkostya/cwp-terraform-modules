locals {
  env  = "DEV"
  tags = {}
}




module "naming" {
  source           = "../../../modules/naming"
  application_code = "My-App"
  environment      = local.env
}




## Using the official 'azure' naming module output
resource "azurerm_resource_group" "this" {
  name = module.naming.azure.resource_group.name

  location = var.location.name
  tags     = local.tags
}


## Using the official 'azure' naming module output with a random unique suffix
resource "azurerm_log_analytics_workspace" "this" {
  name = module.naming.azure.log_analytics_workspace.name_unique

  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}


## Using the 'custom' redefined output
resource "azurerm_user_assigned_identity" "this" {
  name = module.naming.custom.user_assigned_identity.name

  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  tags                = local.tags
}


## Using only the 'name_suffix' output
resource "azurerm_dev_center" "this" {
  name = "devcenter-${module.naming.name_suffix}"

  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
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
