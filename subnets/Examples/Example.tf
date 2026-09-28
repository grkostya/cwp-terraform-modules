provider "azurerm" {
  features {}
}

locals {
  name_suffix     = "prod"
  additional_tags = { Environment = "Production" }
  subnets = {
    web = {
      address_prefixes  = ["10.0.1.0/24"]
      route_table_id    = null
      service_endpoints = ["Microsoft.Storage"]
      nsg_rules = {
        "allow_https" = {
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      }
      delegation = null
    }
    app = {
      address_prefixes  = ["10.0.2.0/24"]
      route_table_id    = null
      service_endpoints = []
      nsg_rules         = {}
      delegation        = null
    }
  }
}

data "azurerm_virtual_network" "this" {
  name                = "my-vnet"
  resource_group_name = "my-resource-group"
}

module "subnets" {
  source = "../../../modules/subnets"


  for_each = local.subnets

  vnet = data.azurerm_virtual_network.this

  subnet_name      = "snet-${each.key}-${local.name_suffix}"
  address_prefixes = each.value.address_prefixes

  use_udr           = true
  route_table_id    = try(each.value.route_table_id, null)
  service_endpoints = try(each.value.service_endpoints, [])
  nsg_rules         = try(each.value.nsg_rules, {})
  delegation        = try(each.value.delegation, null)

  additional_tags = local.additional_tags
}




###########################################################################
## Required providers (to pass TFLint checks)

terraform {
  required_version = ">= 1.9.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.0.0"
    }
  }
}
