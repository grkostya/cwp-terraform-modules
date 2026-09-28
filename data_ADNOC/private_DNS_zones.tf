locals {
  private_DNS_zones = toset(compact([
    ## Key Vault
    "privatelink.vaultcore.azure.net",

    ## AKS
    "privatelink.uaenorth.azmk8s.io",

    ## Storage Account
    "privatelink.blob.core.windows.net",
    "privatelink.file.core.windows.net",
    "privatelink.web.core.windows.net",
    "privatelink.queue.core.windows.net",
    "privatelink.table.core.windows.net",
    "privatelink.dfs.core.windows.net",

    ## PostgreSQL
    "privatelink.postgres.database.azure.com",

    ## CosmosDB
    "privatelink.documents.azure.com",
    "privatelink.mongo.cosmos.azure.com",

    ## Container Registry
    "privatelink.azurecr.io",

    ## ML Workspace
    contains(["dev", "uat", ], local.env) ? "privatelink.notebooks.azure.net" : null,
    contains(["dev", "uat", ], local.env) ? "privatelink.api.azureml.ms" : null,

    ## Purview
    # "privatelink.purview.azure.com",

    ## Monitor
    "privatelink.monitor.azure.com",
    "privatelink.oms.opinsights.azure.com",
    "privatelink.ods.opinsights.azure.com",
    "privatelink.agentsvc.azure-automation.net",
    "privatelink.uaenorth.prometheus.monitor.azure.com", ## Prometheus
    "privatelink.grafana.azure.com",                     ## Grafana

    ## Azure AI services
    "privatelink.cognitiveservices.azure.com",
    "privatelink.openai.azure.com",
    "privatelink.services.ai.azure.com",
    "privatelink.search.windows.net", ## AI Search

    ## WEB
    "privatelink.azurewebsites.net",
    "scm.azurewebsites.net",

    ## QUEUE
    "privatelink.servicebus.windows.net",

    ## APIM
    "azure-api.net",

    ## Redis Cache
    "privatelink.redis.azure.net",
    "privatelink.redis.cache.windows.net",

    ## Backup (Recovery Service Vault)
    "privatelink.uan.backup.windowsazure.com",
  ]))
}




data "azurerm_private_dns_zone" "this" {
  for_each = var.get_private_DNS_zones ? local.private_DNS_zones : []

  name                = each.value
  resource_group_name = data.azurerm_resource_group.Networking[0].name
}
