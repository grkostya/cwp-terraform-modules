locals {
  k8s_service_account_name = coalesce(var.k8s_service_account_name, azurerm_user_assigned_identity.this.name)
  federation_name          = coalesce(var.federation_name, local.k8s_service_account_name)

  default_k8s_annotations = {
    "azure.workload.identity/client-id" = azurerm_user_assigned_identity.this.client_id
  }

  annotations = merge(local.default_k8s_annotations, var.k8s_annotations)

  default_k8s_labels = {
    "app.kubernetes.io/managed-by" = "Terraform"
  }

  labels = merge(local.default_k8s_labels, var.k8s_labels)

  resource_group_name = coalesce(var.resource_group_name, try(var.resource_group.name, null))

  location = coalesce(var.location, try(var.resource_group.location, null))

}
