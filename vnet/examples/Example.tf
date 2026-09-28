locals {
  env = terraform.workspace

  main_vnet = {
    name          = "vnet-name-${local.env}"
    address_space = ["10.0.0.0/16"]
    default_subnet = {
      name             = "default"
      address_prefixes = ["10.0.0.0/24"]
    }
  }

  NSG_rules = {
    # Inbound ##########################
    "SSH_MyIP" = {
      priority                   = 103
      direction                  = "Inbound"
      access                     = "Allow"
      source_address_prefixes    = ["0.0.0.0", ]
      source_port_range          = "*"
      destination_address_prefix = "*"
      destination_port_range     = "22"
      protocol                   = "Tcp"
    }
    # Outbound #########################
    "DenySMTP" = {
      priority                   = 1101
      direction                  = "Outbound"
      access                     = "Deny"
      source_address_prefix      = "*"
      source_port_range          = "*"
      destination_address_prefix = "*"
      destination_port_range     = "25"
      protocol                   = "*"
      description                = "25"
    }
  }
}



data "azurerm_resource_group" "Main" {
  name = "resource-group-name"
}


#########################################################
### Virtual Network

module "MAIN_VNET" {
  source = "../../../modules/vnet"

  vnet_name      = local.main_vnet.name
  resource_group = data.azurerm_resource_group.Main
  default_subnet = local.main_vnet.default_subnet
  nsg_rules      = local.NSG_rules
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
