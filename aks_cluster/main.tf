resource "azurerm_kubernetes_cluster" "this" {
  # depends_on = [ azurerm_role_assignment.AKS_DNS ] ## See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster (BYO DNS Zone note)

  name                = local.cluster_name
  location            = local.location
  resource_group_name = local.resource_group_name
  tags                = local.tags

  sku_tier                  = var.sku_tier
  kubernetes_version        = var.kubernetes_version
  automatic_upgrade_channel = var.automatic_upgrade_channel
  dns_prefix                = lower(local.cluster_name)

  disk_encryption_set_id = var.disk_encryption_set_id


  ## Identities ######################################################
  identity {
    type         = var.identity.type
    identity_ids = var.identity.identity_ids
  }
  kubelet_identity {}

  workload_identity_enabled = true
  oidc_issuer_enabled       = true


  ## API Server ######################################################
  private_cluster_enabled             = var.private_cluster_enabled
  private_cluster_public_fqdn_enabled = var.private_cluster_public_fqdn_enabled
  private_dns_zone_id                 = var.private_dns_zone_id

  # dynamic "api_server_access_profile" {
  #   for_each = var.private_cluster_enabled == false ? [1] : []
  #   content {
  #     authorized_ip_ranges                = var.authorized_ip_ranges
  #     virtual_network_integration_enabled = var.virtual_network_integration_enabled
  #   }
  # }
  dynamic "api_server_access_profile" {
    for_each = var.api_server_access_profile == null ? [] : [var.api_server_access_profile]
    content {
      authorized_ip_ranges                = api_server_access_profile.value.authorized_ip_ranges
      virtual_network_integration_enabled = local.virtual_network_integration_enabled
      subnet_id                           = api_server_access_profile.value.subnet_id
    }
  }


  ## KMS etcd encryption
  dynamic "key_management_service" {
    for_each = var.key_management_service == null ? [] : [var.key_management_service]

    content {
      key_vault_key_id         = key_management_service.value.key_vault_key_id
      key_vault_network_access = key_management_service.value.key_vault_network_access
    }
  }

  ## AuthN/authZ #####################################################
  local_account_disabled            = var.local_account_disabled
  role_based_access_control_enabled = true
  azure_active_directory_role_based_access_control {
    azure_rbac_enabled     = var.azure_rbac_enabled
    admin_group_object_ids = var.admin_group_object_ids
  }


  ## Networking ######################################################
  network_profile {
    network_plugin      = var.network_profile.network_plugin
    network_plugin_mode = var.network_profile.network_plugin_mode
    network_data_plane  = var.network_profile.network_data_plane
    network_policy      = var.network_profile.network_policy
    outbound_type       = var.network_profile.outbound_type
  }


  ## Add-ons #########################################################

  ## Cost Analysis
  cost_analysis_enabled = var.cost_analysis_enabled

  ## Log Analytics
  dynamic "oms_agent" {
    for_each = var.oms_agent != null ? [var.oms_agent] : []
    content {
      log_analytics_workspace_id      = oms_agent.value.log_analytics_workspace_id
      msi_auth_for_monitoring_enabled = oms_agent.value.msi_auth_for_monitoring_enabled
    }
  }

  ## AGIC
  dynamic "ingress_application_gateway" {
    for_each = var.ingress_application_gateway.gateway_id == null ? [] : [1]
    content {
      gateway_id = var.ingress_application_gateway.gateway_id
    }
  }

  ## Nginx Ingress Controller
  # http_application_routing_enabled = var.http_application_routing_enabled
  dynamic "web_app_routing" {
    for_each = var.web_app_routing != null ? [var.web_app_routing] : []
    content {
      dns_zone_ids             = web_app_routing.value.dns_zone_ids
      default_nginx_controller = web_app_routing.value.default_nginx_controller
    }
  }

  dynamic "workload_autoscaler_profile" {
    for_each = var.keda_enabled ? [var.keda_enabled] : []
    content {
      keda_enabled                    = workload_autoscaler_profile.value
      vertical_pod_autoscaler_enabled = false
    }
  }

  dynamic "microsoft_defender" {
    for_each = local.microsoft_defender_log_analytics_workspace_id == null ? [] : [local.microsoft_defender_log_analytics_workspace_id]
    content {
      log_analytics_workspace_id = microsoft_defender.value
    }
  }

  azure_policy_enabled      = var.azure_policy_enabled
  open_service_mesh_enabled = var.open_service_mesh_enabled
  run_command_enabled       = false

  storage_profile {
    blob_driver_enabled         = true
    disk_driver_enabled         = true ## Default
    file_driver_enabled         = false
    snapshot_controller_enabled = true ## Default

  }

  dynamic "monitor_metrics" {
    for_each = var.monitor_metrics != null ? [var.monitor_metrics] : []

    content {
      annotations_allowed = var.monitor_metrics.annotations_allowed
      labels_allowed      = var.monitor_metrics.labels_allowed
    }
  }


  dynamic "key_vault_secrets_provider" {
    for_each = var.key_vault_secrets_provider != null ? [var.key_vault_secrets_provider] : []

    content {
      secret_rotation_enabled  = key_vault_secrets_provider.value.secret_rotation_enabled
      secret_rotation_interval = key_vault_secrets_provider.value.secret_rotation_interval
    }
  }



  ## Maintenance #####################################################
  maintenance_window_node_os {
    day_of_month = var.maintenance_window.day_of_month
    day_of_week  = var.maintenance_window.day_of_week
    duration     = var.maintenance_window.duration
    frequency    = var.maintenance_window.frequency
    interval     = var.maintenance_window.interval
    start_time   = var.maintenance_window.start_time
    utc_offset   = var.maintenance_window.utc_offset
  }

  maintenance_window_auto_upgrade {
    day_of_month = var.maintenance_window.day_of_month
    day_of_week  = var.maintenance_window.day_of_week
    duration     = var.maintenance_window.duration
    frequency    = var.maintenance_window.frequency
    interval     = var.maintenance_window.interval
    start_time   = var.maintenance_window.start_time
    utc_offset   = var.maintenance_window.utc_offset
  }


  ## System Nodepool #################################################
  node_resource_group = local.node_resource_group

  default_node_pool {
    name                    = var.default_node_pool.name                   ## "system"
    os_sku                  = var.default_node_pool.os_sku                 ## "Ubuntu"
    os_disk_type            = var.default_node_pool.os_disk_type           ## "Ephemeral"
    auto_scaling_enabled    = var.default_node_pool.auto_scaling_enabled   ## true
    host_encryption_enabled = var.default_node_pool.enable_host_encryption ## true
    min_count               = var.default_node_pool.min_count              ## 2 (A minimum of 3 nodes of 8 vCPUs or 2 nodes of at least 16 vCPUs is recommended)
    max_count               = var.default_node_pool.max_count              ## 4
    vm_size                 = var.default_node_pool.vm_size                ## "Standard_D4ds_v5"
    zones                   = var.default_node_pool.zones                  ## []
    vnet_subnet_id          = var.default_node_pool.vnet_subnet_id

    # Allow only system workloads on the nodepool
    # (Enabling this option will taint default node pool with "CriticalAddonsOnly=true:NoSchedule" taint.)
    only_critical_addons_enabled = var.default_node_pool.only_critical_addons_enabled

    temporary_name_for_rotation = "rotation"

    upgrade_settings {
      max_surge = "10%"
    }

    tags = local.tags
  }


  lifecycle {
    ignore_changes = [
      kubernetes_version,
      microsoft_defender,
      upgrade_override,
    ]
  }
}
