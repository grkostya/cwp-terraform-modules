resource "azurerm_kubernetes_cluster_node_pool" "this" {
  kubernetes_cluster_id = var.kubernetes_cluster_id
  vnet_subnet_id        = var.vnet_subnet_id

  name     = local.name   ## "user"
  mode     = var.mode     ## "User"
  priority = var.priority ## "Regular" or "Spot". Defaults to "Regular"
  zones    = var.zones    ## []
  tags     = local.tags

  pod_subnet_id           = var.pod_subnet_id           ## null
  node_public_ip_enabled  = var.node_public_ip_enabled  ## false
  ultra_ssd_enabled       = var.ultra_ssd_enabled       ##false
  vm_size                 = var.vm_size                 ## "Standard_D4ds_v5"
  os_sku                  = var.os_sku                  ## "Ubuntu"
  os_disk_type            = var.os_disk_type            ## "Ephemeral"
  os_disk_size_gb         = var.os_disk_size_gb         ## 128
  host_encryption_enabled = var.host_encryption_enabled ## true
  max_pods                = var.max_pods                ## 30
  gpu_instance            = var.gpu_instance            ## null
  gpu_driver              = var.gpu_driver              ## "Install"

  auto_scaling_enabled = var.auto_scaling_enabled ## true
  min_count            = local.min_count          ## 1 ( null - if 'auto_scaling_enabled' set to 'false' )
  max_count            = local.max_count          ## 4 ( null - if 'auto_scaling_enabled' set to 'false' )
  node_count           = local.node_count         ## 1 ( null - if 'auto_scaling_enabled' set to 'true' )

  node_labels = var.node_labels ## {}
  node_taints = var.node_taints ## []

  temporary_name_for_rotation = "rotation"

  upgrade_settings {
    drain_timeout_in_minutes      = var.upgrade_settings.drain_timeout_in_minutes
    max_surge                     = var.upgrade_settings.max_surge
    max_unavailable               = var.upgrade_settings.max_unavailable
    node_soak_duration_in_minutes = var.upgrade_settings.node_soak_duration_in_minutes
  }
  fips_enabled = var.fips_enabled ## false
}
