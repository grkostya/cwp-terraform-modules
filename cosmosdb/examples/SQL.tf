module "CosmosDB" {
  source = "../../../modules/cosmosdb"

  name           = "${module.naming.azure.cosmosdb_account.name}-1"
  resource_group = azurerm_resource_group.this

  ## CMK Encryption
  encryption_key            = azurerm_key_vault_key.Encryption
  user_assigned_identity_id = azurerm_user_assigned_identity.Encryption.id

  # create_sql_database     = true        ## Default: false
  # sql_database_name       = "data"      ## Default: "database"
  # sql_database_containers = ["test", ]  ## Default: []
  # database_throughput     = 1000        ## Default: 400
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
