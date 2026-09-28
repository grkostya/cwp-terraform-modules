# ---------------------------------------------------------------------------------------------------------------------
# OUTPUT VARIABLES
# ---------------------------------------------------------------------------------------------------------------------

output "databricks_workspace_id" {
  description = "The ID of the Databricks workspace."
  value       = azurerm_databricks_workspace.this.id
}

output "databricks_workspace_url" {
  description = "The URL of the Databricks workspace."
  value       = azurerm_databricks_workspace.this.workspace_url
}

output "databricks_managed_resource_group" {
  description = "The name of the managed resource group created by Databricks."
  value       = azurerm_databricks_workspace.this.managed_resource_group_name
}

output "databricks_workspace_name" {
  description = "The name of the Databricks workspace."
  value       = azurerm_databricks_workspace.this.name
}

# output "databricks_workspace_principal_id" {
#   description = "The Managed Identity principal ID for Databricks workspace."
#   value       = azurerm_databricks_workspace.this.managed_identity[0].principal_id
# }

output "databricks_access_connector_id" {
  description = "The ID of the Databricks Access Connector."
  value       = azurerm_databricks_access_connector.this.id
}

output "databricks_private_subnet_id" {
  description = "The ID of the private subnet used by Databricks."
  value       = azurerm_subnet_network_security_group_association.adb_private.subnet_id
}

output "databricks_public_subnet_id" {
  description = "The ID of the public subnet used by Databricks."
  value       = azurerm_subnet_network_security_group_association.adb_public.subnet_id
}

output "databricks_root_dbfs_cmk_key_id" {
  description = "The Key Vault Key ID used for DBFS encryption."
  value       = azurerm_databricks_workspace_root_dbfs_customer_managed_key.this.key_vault_key_id
}
