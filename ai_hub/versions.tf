terraform {
  required_version = ">= 1.9"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~>2.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}
