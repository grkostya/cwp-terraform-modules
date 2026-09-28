locals {
  env = terraform.workspace

  storage_account_name_PRIVATE = "sa${local.env}private"
  storage_account_tier_PRIVATE = lower(local.env) == "prod" ? "Premium" : "Standard"

  vnets = {
    "vnet_1" = {
      name                = "vnet-1"
      resource_group_name = "resource-group-name-1"
    },
    "vnet_2" = {
      name                = "vnet-2"
      resource_group_name = "resource-group-name-2"
    }
  }

  network_rules = {
    ip_rules = ["0.0.0.0", ]
  }
}


data "azurerm_resource_group" "Main" {
  name = "resource-group-name"
}


data "azurerm_virtual_network" "vnets" {
  for_each            = local.vnets
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}


data "azurerm_subnet" "Default" {
  name                 = "default"
  virtual_network_name = local.vnets.vnet_1.name
  resource_group_name  = local.vnets.vnet_1.resource_group_name
}




module "PRIVATE_Storage_Account" {
  source = "../../../modules/storage_account"

  name                     = local.storage_account_name_PRIVATE
  resource_group_name      = data.azurerm_resource_group.Main.name
  location                 = data.azurerm_resource_group.Main.location
  account_tier             = local.storage_account_tier_PRIVATE
  account_replication_type = "ZRS"

  shared_access_key_enabled     = true
  public_network_access_enabled = false ## Default: false

  private_endpoint = {
    existing_private_dns_zone = { # Omit this block to create a new one
      name                = "privatelink.blob.core.windows.net"
      resource_group_name = "resource-group-name-2" # (OPTIONAL)
    }
    # A map of Virtual Networks that should be linked to the DNS Zone
    virtual_networks = data.azurerm_virtual_network.vnets
    #The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint
    subnet_id = data.azurerm_subnet.Default.id
  }

  network_rules = {
    ip_rules = local.network_rules.ip_rules
  }

  tags = merge(data.azurerm_resource_group.Main.tags, { Environment = upper(local.env) })
}
