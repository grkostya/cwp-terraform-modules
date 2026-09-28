resource "azurerm_subnet" "PostgreSQL_Flexible" {
  count = var.delegated_subnet == null ? 0 : 1

  name                 = var.delegated_subnet.name
  resource_group_name  = var.delegated_subnet.resource_group_name
  virtual_network_name = var.delegated_subnet.virtual_network_name
  address_prefixes     = var.delegated_subnet.address_prefixes
  service_endpoints    = ["Microsoft.Storage", "Microsoft.KeyVault"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}


# Private access (VNet integration) or Public access + Private Endpoint
resource "azurerm_private_dns_zone" "PostgreSQL_Flexible" {
  count = local.create_private_dns_zone ? 1 : 0

  name                = local.private_dns_zone_name
  resource_group_name = local.resource_group_name
  tags                = local.tags
}


# Public access (allowed IP addresses)
resource "azurerm_private_endpoint" "this" {
  count = var.private_endpoint_subnet_id == null ? 0 : 1

  name                          = "pe-${azurerm_postgresql_flexible_server.this.name}"
  location                      = local.location
  resource_group_name           = local.resource_group_name
  subnet_id                     = var.private_endpoint_subnet_id
  custom_network_interface_name = "nic-pe-${azurerm_postgresql_flexible_server.this.name}"

  private_service_connection {
    name                           = "pe-${azurerm_postgresql_flexible_server.this.name}"
    private_connection_resource_id = azurerm_postgresql_flexible_server.this.id
    subresource_names              = ["postgresqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = azurerm_postgresql_flexible_server.this.name
    private_dns_zone_ids = [azurerm_private_dns_zone.PostgreSQL_Flexible[0].id]
  }

  tags = azurerm_postgresql_flexible_server.this.tags
}


resource "azurerm_private_dns_zone_virtual_network_link" "PostgreSQL_Flexible" {
  count = local.create_private_dns_zone ? 1 : 0

  name                  = local.vnet_name
  virtual_network_id    = local.vnet_id
  private_dns_zone_name = azurerm_private_dns_zone.PostgreSQL_Flexible[0].name
  resource_group_name   = azurerm_private_dns_zone.PostgreSQL_Flexible[0].resource_group_name
  tags                  = local.tags
}




#########################################################
### PostgreSQL Flexible Server

resource "azurerm_postgresql_flexible_server" "this" {
  depends_on = [azurerm_private_dns_zone_virtual_network_link.PostgreSQL_Flexible]

  name                = var.name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags
  version             = var.pg_version

  public_network_access_enabled = local.public_network_access_enabled
  delegated_subnet_id           = local.delegated_subnet_id #VNet integration
  private_dns_zone_id           = local.private_dns_zone_id

  backup_retention_days = var.backup_retention_days

  storage_mb        = var.storage.mb
  storage_tier      = var.storage.tier
  auto_grow_enabled = var.auto_grow_enabled

  sku_name = var.sku_name

  authentication {
    active_directory_auth_enabled = true
    password_auth_enabled         = var.password_auth_enabled
    tenant_id                     = data.azurerm_client_config.current.tenant_id
  }
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password

  dynamic "identity" {
    for_each = var.identity == null ? [] : ["identity"]
    content {
      type         = var.identity.type
      identity_ids = var.identity.identity_ids
    }
  }

  # Encryption
  dynamic "customer_managed_key" {
    for_each = var.customer_managed_key == null ? [] : ["customer_managed_key"]
    content {
      key_vault_key_id                     = var.customer_managed_key.key_vault_key_id
      primary_user_assigned_identity_id    = var.customer_managed_key.primary_user_assigned_identity_id
      geo_backup_key_vault_key_id          = var.customer_managed_key.geo_backup_key_vault_key_id
      geo_backup_user_assigned_identity_id = var.customer_managed_key.geo_backup_user_assigned_identity_id
    }
  }

  lifecycle {
    ignore_changes = [
      # Ignore changes to zone, to not migrate the PostgreSQL Flexible Server back
      # to it's primary Availability Zone after a fail-over or if the zone is not defined (zone = null).
      zone
    ]
  }
}




#########################################################
### PostgreSQL Flexible Server Administrators

resource "azurerm_postgresql_flexible_server_active_directory_administrator" "users" {
  for_each       = data.azuread_user.db_admins
  object_id      = each.value.object_id
  principal_name = each.value.display_name

  principal_type      = "User"
  server_name         = azurerm_postgresql_flexible_server.this.name
  resource_group_name = azurerm_postgresql_flexible_server.this.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
}


resource "azurerm_postgresql_flexible_server_active_directory_administrator" "groups" {
  for_each       = data.azuread_group.db_admins
  object_id      = each.value.object_id
  principal_name = each.value.display_name

  principal_type      = "Group"
  server_name         = azurerm_postgresql_flexible_server.this.name
  resource_group_name = azurerm_postgresql_flexible_server.this.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
}


resource "azurerm_postgresql_flexible_server_active_directory_administrator" "service_principals" {
  for_each       = data.azuread_service_principal.db_admins
  object_id      = each.value.object_id
  principal_name = each.value.display_name

  principal_type      = "ServicePrincipal"
  server_name         = azurerm_postgresql_flexible_server.this.name
  resource_group_name = azurerm_postgresql_flexible_server.this.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
}




#########################################################
### PostgreSQL Flexible Server Firewall Rules

resource "azurerm_postgresql_flexible_server_firewall_rule" "this" {
  for_each         = local.firewall_rules
  name             = each.key
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address

  server_id = azurerm_postgresql_flexible_server.this.id
}
