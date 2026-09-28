output "id" {
  value = azurerm_kubernetes_cluster.this.id
}

output "name" {
  value = azurerm_kubernetes_cluster.this.name
}

output "kube_config" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.this.kube_config_raw
}

output "kube_config_block" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.this.kube_config
}

output "principal_id" {
  value = azurerm_kubernetes_cluster.this.identity[0].principal_id
}

output "kubelet_identity_id" {
  value = azurerm_kubernetes_cluster.this.kubelet_identity[0].user_assigned_identity_id
}

output "kubelet_object_id" {
  value = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}

output "kubelet_client_id" {
  value = azurerm_kubernetes_cluster.this.kubelet_identity[0].client_id
}

output "node_resource_group" {
  value = azurerm_kubernetes_cluster.this.node_resource_group
}

output "aks_egress_public_ip" {
  value = local.aks_egress_public_ip
}

output "oidc_issuer_url" {
  value = try(azurerm_kubernetes_cluster.this.oidc_issuer_url, null)
}

output "container_insights_data_collection_rule_id" {
  description = "The ID of the Azure Monitor Data Collection Rule used for Container Insights."
  value       = try(azurerm_monitor_data_collection_rule.ContainerInsights[0].id, null)
}
