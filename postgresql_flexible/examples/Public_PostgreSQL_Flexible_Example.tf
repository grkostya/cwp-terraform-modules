locals {
  env = terraform.workspace

  name = "${local.env}-public-db"

  default_database_administrator_object_ids = {
    User             = ["00000000-0000-0000-0000-000000000000", ]
    Group            = []
    ServicePrincipal = []
  }

  # Firewall rules for resources
  firewall_rule_CIDRs = ["1.1.1.0/24", "0.0.0.0", ]

  firewall_rules = {
    "range-1" = {
      start_ip_address = "195.56.119.2"
      end_ip_address   = "195.56.119.20"
    }
    "range-2" = {
      start_ip_address = "37.252.90.1"
      end_ip_address   = "37.252.90.11"
    }
  }

  tags = merge(data.azurerm_resource_group.Main.tags, { Environment = upper(local.env) })
}


data "azurerm_resource_group" "Main" {
  name = "resource-group-name"
}


module "PUBLIC_PostgreSQL_Flexible" {
  source = "../../../modules/postgresql_flexible"

  name                = local.name
  resource_group_name = data.azurerm_resource_group.Main.name
  location            = data.azurerm_resource_group.Main.location
  pg_version          = "15"
  sku_name            = "B_Standard_B1ms"

  # Active Directory Authentication
  default_database_administrator_object_ids = local.default_database_administrator_object_ids

  password_auth_enabled  = true
  administrator_login    = "dbadmin"
  administrator_password = "Temppassword"

  # Provide either 'firewall_rules', 'firewall_rule_CIDRs', or both (will be merged)
  firewall_rules      = local.firewall_rules
  firewall_rule_CIDRs = local.firewall_rule_CIDRs

  # private_endpoint_subnet_id = var.subnet_id  # To create a private endpoint

  tags = local.tags
}
