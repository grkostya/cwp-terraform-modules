locals {
  subnets = toset(compact([
    ## Private Endpoints
    "Private-Endpoints",

    ## AKS
    "aks",
    "aks-API-server",

    ## ML Workspaces
    contains(["dev", "uat", ], local.env) ? "mlws" : null,

    ## PostgreSQL Flexible Server
    "psql",

    ## API Management
    "apim",

    ## Aapplication Gateway for UI
    "appgw",

    ## ADO Self-Hosted Agents
    "ado-agents",

    ## Fucntion App
    "func-app",

    ## AVD
    local.env == "dev" ? "avd" : null,

    ## Security Services
    "sec-svc",

    ## Lustre
    contains(["dev", "uat", ], local.env) ? "lustre" : null,

    ## Databricks
    # "dbx-private",
    # "dbx-public",
  ]))
}



data "azurerm_subnet" "this" {
  for_each = var.get_subnets ? local.subnets : []

  name                 = "snet-${each.key}-${local.subnet_name_suffix}"
  virtual_network_name = data.azurerm_virtual_network.this[0].name
  resource_group_name  = data.azurerm_resource_group.Networking[0].name
}
