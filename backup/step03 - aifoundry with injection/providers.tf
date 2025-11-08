terraform {
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = ">= 2.7.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 3.6.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.51.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.7.2"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.13.1"
    }
  }
}

provider "azapi" {
  alias           = "workload_subscription"
  subscription_id = var.subscription_id_resources
}

provider "azapi" {
  alias           = "infra_subscription"
  subscription_id = var.subscription_id_infra
}

provider "azurerm" {
  alias           = "workload_subscription"
  subscription_id = var.subscription_id_resources
  features {}
  storage_use_azuread = true
}

provider "azurerm" {
  alias           = "infra_subscription"
  subscription_id = var.subscription_id_infra
  features {}
  storage_use_azuread = true
}
