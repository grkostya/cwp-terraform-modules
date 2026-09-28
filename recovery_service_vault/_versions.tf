terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.25"
    }

    time = {
      source  = "hashicorp/time"
      version = ">=0.13.0"
    }
  }
}
