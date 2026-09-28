# Access the client configuration of the AzureRM provider.
data "azurerm_client_config" "this" {}

# Create a Fabric Capacity.
resource "azurerm_fabric_capacity" "this" {
  name                = var.fabric_capacity_name
  resource_group_name = local.resource_group_name
  location            = local.location

  administration_members = setunion([local.uami_principal_id], var.fabric_capacity_admin_upns)

  sku {
    name = var.fabric_capacity_sku
    tier = "Fabric"
  }
  tags = local.tags
}
