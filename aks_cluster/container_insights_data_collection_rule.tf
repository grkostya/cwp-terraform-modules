###########################################################################
## Container Insights Data Collection Rule

resource "azurerm_monitor_data_collection_rule" "ContainerInsights" {
  count = var.oms_agent == null ? 0 : 1

  name                = "MSCI-${local.cluster_name}-DCR"
  resource_group_name = azurerm_kubernetes_cluster.this.node_resource_group
  location            = local.location
  tags                = local.tags

  data_collection_endpoint_id = try(var.oms_agent.container_insights.data_collection_endpoint_id, null)

  destinations {
    log_analytics {
      workspace_resource_id = var.oms_agent.log_analytics_workspace_id
      name                  = "ciworkspace"
    }
  }

  ## Individual data flows for each stream specified in the variable, allowing for optional KQL transformations per stream
  dynamic "data_flow" {
    for_each = var.oms_agent.container_insights.streams
    content {
      streams       = [data_flow.value]
      destinations  = ["ciworkspace"]
      output_stream = data_flow.value
      transform_kql = try(var.oms_agent.container_insights.transform_kql[data_flow.value], null)
    }
  }

  data_sources {
    # syslog{
    #   streams            = ["Microsoft-Syslog"]
    #   facility_names     = ["auth", "authpriv", "cron", "daemon", "mark", "kern", "local0", "local1", "local2", "local3", "local4", "local5", "local6", "local7", "lpr", "mail", "news", "syslog", "user", "uucp"]
    #   log_levels         = ["Debug", "Info", "Notice", "Warning", "Error", "Critical", "Alert", "Emergency"]
    #   name               = "sysLogsDataSource"
    # }

    extension {
      streams        = var.oms_agent.container_insights.streams
      extension_name = "ContainerInsights"
      extension_json = jsonencode({
        dataCollectionSettings = {
          interval               = var.oms_agent.container_insights.data_collection_settings.interval
          namespaceFilteringMode = var.oms_agent.container_insights.data_collection_settings.namespace_filtering_mode
          namespaces             = var.oms_agent.container_insights.data_collection_settings.namespaces
          enableContainerLogV2   = var.oms_agent.container_insights.data_collection_settings.enable_container_log_v2
        }
      })
      name = "ContainerInsightsExtension"
    }
  }

  description = "DCR for Azure Monitor Container Insights"
}




resource "azurerm_monitor_data_collection_rule_association" "ContainerInsights" {
  count = var.oms_agent == null ? 0 : 1

  name                    = "ContainerInsightsExtension"
  target_resource_id      = azurerm_kubernetes_cluster.this.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.ContainerInsights[0].id
  description             = "Association of container insights data collection rule. Deleting this association will break the data collection for this AKS Cluster."
}
