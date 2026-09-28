module "AI_Search" {
  source = "../../../modules/ai_search"

  name                          = "your-search-service-name" ## module.NAMING.azure.search_service.name
  sku                           = "standard"                 ## Default: "standard". Possible values: "basic", "standard", "standard2"
  replica_count                 = 1                          ## Default: 1
  partition_count               = 1                          ## Default: 1
  public_network_access_enabled = true                       ## Default: 1
  semantic_search_sku           = "free"                     ## Default: null. Possible values: "free", "standard"

  resource_group_name = "your-resource-group"
  location            = "UAE North"
  tags = {
    Environment = "dev"
    Project     = "Agentic"
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
  }
}
