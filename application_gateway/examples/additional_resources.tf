# resource "azurerm_public_ip" "application_gateway" {
#   name                 = "pip-appgw"
#   resource_group_name  = "local.resource_group_name"
#   location             = "local.location"
#   tags                 = "local.tags"
#   allocation_method    = "Static"
#   sku                  = "Standard"
#   domain_name_label    = "mysubdomain"
#   ddos_protection_mode = "Enabled"
# }


resource "azurerm_subnet" "application_gateway" {
  name                 = "snet-appgw"
  resource_group_name  = "local.resource_group_name"
  virtual_network_name = data.azurerm_virtual_network.this.name
  address_prefixes     = ["local.agic_subnet_address_prefix"]
  service_endpoints    = ["local.agic_subnet_service_endpoints"]
}


###########################################################################
### RBAC assigments required for AGIC

# resource "azurerm_role_assignment" "AGIC_RG_Reader" {
#   scope                = azurerm_resource_group.this.id
#   role_definition_name = "Reader"
#   principal_id         = azurerm_kubernetes_cluster.this.ingress_application_gateway.0.ingress_application_gateway_identity.0.object_id
# }


# resource "azurerm_role_assignment" "AGIC_Contributor" {
#   scope                = azurerm_application_gateway.this.id
#   role_definition_name = "Contributor"
#   principal_id         = azurerm_kubernetes_cluster.this.ingress_application_gateway.0.ingress_application_gateway_identity.0.object_id
# }


# resource "azurerm_role_assignment" "AGIC_Network_Contributor" {
#   scope                = data.azurerm_subnet.application_gateway.id
#   role_definition_name = "Network Contributor"
#   principal_id         = azurerm_kubernetes_cluster.this.ingress_application_gateway.0.ingress_application_gateway_identity.0.object_id
# }
















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
