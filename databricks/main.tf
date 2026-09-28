resource "azurerm_databricks_workspace" "this" {
  name                                  = var.adb_workspace_name
  resource_group_name                   = local.resource_group_name
  managed_resource_group_name           = var.adb_managed_rg_name # The name of the resource group where Azure should place the managed Databricks resources.
  location                              = local.location
  sku                                   = "premium"
  public_network_access_enabled         = false
  network_security_group_rules_required = "NoAzureDatabricksRules"

  # Creates Storage Account identity used for DBFS encryption
  customer_managed_key_enabled                        = true
  managed_services_cmk_key_vault_key_id               = var.managed_services_cmk_key_vault_key_id
  managed_disk_cmk_rotation_to_latest_version_enabled = true
  managed_disk_cmk_key_vault_key_id                   = var.managed_disk_cmk_key_vault_key_id

  default_storage_firewall_enabled = true
  access_connector_id              = try(azurerm_databricks_access_connector.this.id, null)

  custom_parameters {
    no_public_ip                                         = true
    virtual_network_id                                   = var.vnet_id
    private_subnet_name                                  = var.adb_subnet_private_name
    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.adb_private.id
    public_subnet_name                                   = var.adb_subnet_public_name
    public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.adb_public.id
    storage_account_name                                 = var.adb_storage_account_name
  }
  tags = local.tags

  depends_on = [
    azurerm_subnet_network_security_group_association.adb_private,
    azurerm_subnet_network_security_group_association.adb_public
  ]
}

# DBFS encryption with CMK
resource "azurerm_databricks_workspace_root_dbfs_customer_managed_key" "this" {
  workspace_id     = azurerm_databricks_workspace.this.id
  key_vault_key_id = var.adb_dbfs_key_vault_key_id

  #depends_on = [azurerm_key_vault_access_policy.databricks_storage_account_msi]

  lifecycle { ignore_changes = [key_vault_key_id] } # Used for automated keys rotation
}

# ---------------------------------------------------------------------------------------------------------------------------
# CREATE ADB CONNECTOR
# ---------------------------------------------------------------------------------------------------------------------------
resource "azurerm_databricks_access_connector" "this" {
  name                = var.adb_connector_name
  resource_group_name = local.resource_group_name
  location            = local.location
  identity {
    type = "SystemAssigned" # Use "UserAssigned" if you prefer a user-assigned identity
  }
  tags = local.tags
}

resource "azurerm_subnet_network_security_group_association" "adb_public" {
  subnet_id                 = var.adb_subnet_public_id
  network_security_group_id = var.nsg_adb_public_id
}

resource "azurerm_subnet_network_security_group_association" "adb_private" {
  subnet_id                 = var.adb_subnet_private_id
  network_security_group_id = var.nsg_adb_private_id
}
