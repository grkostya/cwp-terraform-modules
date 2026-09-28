terraform {
  required_version = ">= 1.9.8"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.10.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">=2.5.1"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.6.2"
    }
  }
}
