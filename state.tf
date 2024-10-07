provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.4.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "1.6.0"
    }
  }
}