module "AKS_Nodepool_1" {
  source = "../../../modules/aks_nodepool"

  name                  = "agntc"
  vnet_subnet_id        = data.azurerm_subnet.AKS.id
  kubernetes_cluster_id = data.azurerm_kubernetes_cluster.this.id
  tags                  = {}

  max_count   = 8 ## Max node instances for autoscaling. Default: 4
  node_taints = ["app=agentic:NoSchedule"]
}


module "AKS_Nodepool_RAG_GPU" {
  source = "../../../modules/aks_nodepool"

  name                  = "agntcgpu"
  vnet_subnet_id        = data.azurerm_subnet.AKS.id
  kubernetes_cluster_id = data.azurerm_kubernetes_cluster.this.id
  tags                  = {}

  vm_size              = "Standard_NV6ads_A10_v5" ## Default: "Standard_D4ds_v5"
  auto_scaling_enabled = false                    ## Default: true
  node_count           = 1
  node_taints          = ["app=agentic:NoSchedule", "sku=gpu:NoSchedule"]
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
