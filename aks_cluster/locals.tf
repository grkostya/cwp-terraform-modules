locals {
  resource_group_name = coalesce(var.resource_group_name, try(var.resource_group.name, null))
  location            = coalesce(var.location, try(var.resource_group.location, null))

  cluster_name        = var.name
  node_resource_group = "MC_${local.resource_group_name}_${local.cluster_name}"

  aks_egress_public_ip = var.network_profile.outbound_type == "loadBalancer" ? data.azurerm_public_ip.aks_egress_ip[0].ip_address : ""

  ## API Server VNet integration
  virtual_network_integration_enabled = try(var.api_server_access_profile.subnet_id, null) == null ? false : true

  ## Defender profile log analytics workspace ID
  microsoft_defender_log_analytics_workspace_id = try(var.oms_agent.log_analytics_workspace_id, null)
}
