###########################################################################
## Get Kubernetes egress public IP address

# data "azurerm_public_ip" "aks_egress_ip" {
#   count = var.network_profile.outbound_type == "loadBalancer" ? 1 : 0
#   name                = regex("^/.*/publicipaddresses/(.*)$", lower(one(azurerm_kubernetes_cluster.this.network_profile[0].load_balancer_profile[0].effective_outbound_ips)))[0]
#   resource_group_name = azurerm_kubernetes_cluster.this.node_resource_group
# }


data "azurerm_public_ip" "aks_egress_ip" {
  count               = var.network_profile.outbound_type == "loadBalancer" ? 1 : 0
  name                = split("/", tolist(azurerm_kubernetes_cluster.this.network_profile[0].load_balancer_profile[0].effective_outbound_ips)[0])[8]
  resource_group_name = azurerm_kubernetes_cluster.this.node_resource_group
}


# data "azurerm_resource_group" "main" {
#   name = local.resource_group_name
# }


# data "azurerm_resource_group" "VNet" {
#   name = regex("^/.*/resource[gG]roups/(.*)/providers/.*$", lower(var.default_node_pool.vnet_subnet_id))[0]
# }


data "azurerm_user_assigned_identity" "cluster_identity" {
  count = var.identity.type == "UserAssigned" ? 1 : 0

  name                = split("/", var.identity.identity_ids[0])[8]
  resource_group_name = split("/", var.identity.identity_ids[0])[4]
}
