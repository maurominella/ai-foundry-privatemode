### Terraform Providers Configuration
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

### Provider for Agents Subscription
provider "azapi" {
  alias           = "subscription_agents"
  subscription_id = var.subscription_id_agents
}
provider "azurerm" {
  alias           = "subscription_agents"
  subscription_id = var.subscription_id_agents
  features {}
  storage_use_azuread = true
}

### Provider for Storage Subscription
provider "azapi" {
  alias           = "subscription_storage"
  subscription_id = var.subscription_id_storage
}
provider "azurerm" {
  alias           = "subscription_storage"
  subscription_id = var.subscription_id_storage
  features {}
  storage_use_azuread = true
}

### Provider for CosmosDB Subscription
provider "azapi" {
  alias           = "subscription_cosmosdb"
  subscription_id = var.subscription_id_cosmosdb
}
provider "azurerm" {
  alias           = "subscription_cosmosdb"
  subscription_id = var.subscription_id_cosmosdb
  features {}
  storage_use_azuread = true
}

### Provider for AISearch Subscription
provider "azapi" {
  alias           = "subscription_aisearch"
  subscription_id = var.subscription_id_aisearch
}
provider "azurerm" {
  alias           = "subscription_aisearch"
  subscription_id = var.subscription_id_aisearch
  features {}
  storage_use_azuread = true
}

### Provider for Networking Subscription
provider "azapi" {
  alias           = "subscription_networking"
  subscription_id = var.subscription_id_networking
}
provider "azurerm" {
  alias           = "subscription_networking"
  subscription_id = var.subscription_id_networking
  features {}
  storage_use_azuread = true
}
