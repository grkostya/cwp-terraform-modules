## Requred to use with an existing private DNS zone
resource "azurerm_user_assigned_identity" "AKS" {
  name                = "${module.naming.custom.user_assigned_identity.name}-aks-cluster"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  tags                = azurerm_resource_group.this.tags
}


resource "azurerm_role_assignment" "AKS_Private_DNS_Zone" {
  scope                = data.azurerm_private_dns_zone.AKS.id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.AKS.principal_id
}


### To enable KMS for etcd encryption
# resource "azurerm_role_assignment" "AKS_Key_Vault_Crypto_User" {
#   scope                = module.Key_Vault.id
#   role_definition_name = "Key Vault Crypto User"
#   principal_id         = azurerm_user_assigned_identity.AKS.principal_id
# }




module "AKS" {
  source = "../../../modules/aks_cluster"

  ## See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster - BYO DNS Zone note:
  ## If you use BYO DNS Zone, the AKS cluster should use a User Assigned Identity
  ## with the 'Private DNS Zone Contributor role' and access to this Private DNS Zone.
  ## To prevent improper resource order destruction - the cluster should depend on the role assignment
  depends_on = [azurerm_role_assignment.AKS_Private_DNS_Zone]

  name           = module.naming.azure.kubernetes_cluster.name
  resource_group = azurerm_resource_group.this

  kubernetes_version = "1.31" ## null for the latest

  disk_encryption_set_id = azurerm_disk_encryption_set.this.id

  # oms_agent = {
  #   log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
  #
  #   ## OPTIANAL. Default values for the container_insights object are set in the variable definition (except for the transform_kql)
  #   # container_insights = {
  #   #   streams = [
  #   #     "Microsoft-ContainerLogV2",
  #   #     "Microsoft-KubeEvents",
  #   #     "Microsoft-KubePodInventory",
  #   #     "Microsoft-KubeNodeInventory",
  #   #     "Microsoft-KubePVInventory",
  #   #     "Microsoft-KubeServices",
  #   #     "Microsoft-KubeMonAgentEvents",
  #   #     "Microsoft-InsightsMetrics",
  #   #     "Microsoft-ContainerInventory",
  #   #     "Microsoft-ContainerNodeInventory",
  #   #     "Microsoft-Perf"
  #   #   ]
  #   #   data_collection_endpoint_id = null
  #   #   data_collection_settings = {
  #   #     interval                 = "1m"
  #   #     namespace_filtering_mode = "Off"
  #   #     namespaces               = ["kube-system", "gatekeeper-system", "azure-arc"]
  #   #     enable_container_log_v2  = true
  #   #   }
  #   #   transform_kql = {
  #   #     "Microsoft-ContainerLogV2" = <<KQL
  #   #       source | where not(LogMessage matches regex @"(?i)GET.*/health.*[2,3][0-9]{2}( |$)")
  #   #     KQL
  #   #   }
  #   # }
  # }

  network_profile = {
    network_plugin      = "azure"              ## Default: "azure"
    network_policy      = "azure"              ## Default: "azure"
    network_plugin_mode = "overlay"            ## Default: null
    outbound_type       = "userDefinedRouting" ## Default: "loadBalancer"
  }

  default_node_pool = {
    vnet_subnet_id = data.azurerm_subnet.AKS.id
  }

  ## To use an existing private DNS zone. Default: type = "SystemAssigned", identity_ids = []
  identity = {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.AKS.id]
  }
  # private_cluster_public_fqdn_enabled = true ## Use if 'private_dns_zone_id' set to "None"
  private_dns_zone_id = data.azurerm_private_dns_zone.AKS.id ## "None" ## Default: "System"

  ## API Server VNet integration (required to enable KMS)
  # api_server_access_profile = {
  #   subnet_id = module.DATA.subnet["aks-API-server"].id  ## Nodepool subnet is not allowed
  # }
  ## KMS etcd encryption
  # key_management_service = {
  #   key_vault_key_id = module.Key_Vault.id
  #   key_vault_network_access = "Public" ## Default: "Private"
  # }

  ## Assign Microsoft Entra groups that will have admin access within the cluster
  # admin_group_object_ids              = []

  ## Enable Diagnostic Settings for the AKS cluster
  # diagnostic_setting_enabled = true ## Default: false

}
















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
