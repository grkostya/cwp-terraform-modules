locals {
  env = terraform.workspace

  vnets = {
    "vnet-1" = {
      name                = "vnet-1"
      resource_group_name = "resource-group-name-1"
    },
    "vnet-2" = {
      name                = "vnet-2"
      resource_group_name = "resource-group-name-2"
    }
  }


  # PostgreSQL
  pg_name     = "${local.env}-private-db"
  pg_sku_name = "B_Standard_B1ms"

  pg_subnet = {
    name             = "postgresql-${local.env}"
    address_prefixes = ["10.10.2.0/24"]
  }

  pg_storage = {
    mb   = lower(local.env) == "prod" ? 32768 : 32768
    tier = lower(local.env) == "prod" ? "P4" : "P4"
  }

  default_database_administrator_object_ids = {
    User             = ["00000000-0000-0000-0000-000000000000", ]
    Group            = []
    ServicePrincipal = []
  }

  tags = merge(data.azurerm_resource_group.Main.tags, { Environment = upper(local.env) })
}




data "azurerm_resource_group" "Main" {
  name = "resource-group-name"
}


data "azurerm_virtual_network" "vnets" {
  for_each            = local.vnets
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}




module "PRIVATE_PostgreSQL_Flexible" {
  source = "../../../modules/postgresql_flexible"

  name           = local.pg_name
  resource_group = data.azurerm_resource_group.Main
  # resource_group_name = data.azurerm_resource_group.Main.name
  # location            = data.azurerm_resource_group.Main.location
  pg_version = "15"
  sku_name   = local.pg_sku_name
  storage    = local.pg_storage

  delegated_subnet = {
    name                 = local.pg_subnet.name
    address_prefixes     = local.pg_subnet.address_prefixes
    resource_group_name  = data.azurerm_virtual_network.vnets["vnet-1"].resource_group_name
    virtual_network_name = data.azurerm_virtual_network.vnets["vnet-1"].name
  }

  # Active Directory Authentication
  default_database_administrator_object_ids = local.default_database_administrator_object_ids

  # tags = local.tags # Set '{}' to delete tags
}
