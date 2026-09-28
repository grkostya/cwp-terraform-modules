provider "kubernetes" {
  config_path = "~/.kube/config"
}


data "azurerm_resource_group" "this" {
  name = "resource-group-name"
}


data "azurerm_kubernetes_cluster" "this" {
  name                = "aks-cluster-name"
  resource_group_name = data.azurerm_resource_group.Main.name
}


locals {
  federated_credential = {
    oidc_issuer_url = data.azurerm_kubernetes_cluster.this.oidc_issuer_url
    # audience = [""]
  }
}


#########################################################
### Workload Identities

module "AKS_Workload_Identity_1" {
  source = "../../../modules/aks_workload_identity"

  identity_name              = "managed-identity-name"
  resource_group             = data.azurerm_resource_group.this
  create_k8s_service_account = false
}




module "AKS_Workload_Identity_2" {
  source = "../../../modules/aks_workload_identity"

  identity_name        = "managed-identity-name"
  resource_group       = data.azurerm_resource_group.this
  federated_credential = local.federated_credential
  k8s_namespace        = "namespace-name"

  k8s_labels = {
    "label" = "value"
  }

  k8s_annotations = {
    "annotation" = "value"
  }

  RBAC_roles = {
    Reader = {
      scope     = data.azurerm_resource_group.this.id
      role_name = "Reader"
    },
  }
}
















###########################################################################
## Required providers (to pass TFLint checks)

terraform {
  required_version = ">= 1.9.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.27.0"
    }
  }
}
