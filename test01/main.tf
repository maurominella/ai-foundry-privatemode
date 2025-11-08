########## Create infrastructure resources
##########

## Create a random string
##
resource "random_string" "unique" {
  length      = 4
  min_numeric = 4
  numeric     = true
  special     = false
  lower       = true
  upper       = false
}

########## Create resoures required to for agent data storage
##########

## Create a VNETclear

resource "azurerm_virtual_network" "vnet" {
  provider = azurerm.infra_subscription

  name                = "vnet-${random_string.unique.result}"
  address_space       = ["172.25.0.0/16"]
  location            = var.location_agents
  resource_group_name = var.resourcegroup_name_agents
}

resource "azurerm_subnet" "agents_subnet" {
  provider = azurerm.infra_subscription
  name                 = var.subnet_agents_name
  resource_group_name  = var.resourcegroup_name_agents
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["172.25.1.0/24"]

  delegation {
    name = "Microsoft.App/environments"
    service_delegation {
      name = "Microsoft.App/environments"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]
    }
  }
}

resource "azurerm_subnet" "resourcespe_subnet" {
  provider = azurerm.infra_subscription
  name                 = var.subnet_resourcespe_name
  resource_group_name  = var.resourcegroup_name_agents
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["172.25.2.0/24"]
}

## Create a storage account for agent data
##
resource "azurerm_storage_account" "storage_account" {
  provider = azurerm.workload_subscription
  name                = "aifoundry${random_string.unique.result}storage"
  resource_group_name = var.resourcegroup_name_resources
  location            = var.location_agents
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "ZRS"
  ## Identity configuration
  shared_access_key_enabled = false
  ## Network access configuration
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  network_rules {
    default_action = "Deny"
    bypass = [
      "AzureServices"
    ]
  }
}

# ## Create the Cosmos DB account to store agent threads
# ##
resource "azurerm_cosmosdb_account" "cosmosdb" {
  provider = azurerm.workload_subscription
  name                = "aifoundry${random_string.unique.result}cosmosdb"
  location            = var.location_agents
  resource_group_name = var.resourcegroup_name_resources

  # General settings
  offer_type        = "Standard"
  kind              = "GlobalDocumentDB"
  free_tier_enabled = false

  # Set security-related settings
  local_authentication_disabled = true
  public_network_access_enabled = false

  # Set high availability and failover settings
  automatic_failover_enabled       = false
  multiple_write_locations_enabled = false

  # Configure consistency settings
  consistency_policy {
    consistency_level = "Session"
  }

  # Configure single location with no zone redundancy to reduce costs
  geo_location {
    location          = var.location_agents
    failover_priority = 0
    zone_redundant    = false
  }
}


# ## Create an AI Search instance that will be used to store vector embeddings
# ##
resource "azapi_resource" "ai_search" {
  provider = azapi.workload_subscription
  type                      = "Microsoft.Search/searchServices@2025-05-01"
  name                      = "aifoundry${random_string.unique.result}search"
  parent_id                 = "/subscriptions/${var.subscription_id_resources}/resourceGroups/${var.resourcegroup_name_resources}"
  location                  = var.location_resources
  schema_validation_enabled = true
  body = {
    sku = {
      name = "standard"
    }
    identity = {
      type = "SystemAssigned"
    }
    properties = {
      # Search-specific properties
      replicaCount   = 1
      partitionCount = 1
      hostingMode    = "default"
      semanticSearch = "disabled"

      # Identity-related controls
      disableLocalAuth = false
      authOptions = {
        aadOrApiKey = {
          aadAuthFailureMode = "http401WithBearerChallenge"
        }
      }

      # Networking-related controls
      publicNetworkAccess = "Disabled"
      networkRuleSet = {
        bypass = "None"
      }
    }
  }
}


## Create the AI Foundry resource
##
resource "azapi_resource" "ai_foundry" {
  provider = azapi.infra_subscription
  type                      = "Microsoft.CognitiveServices/accounts@2025-06-01"
  name                      = "aifoundry${random_string.unique.result}"
  parent_id                 = "/subscriptions/${var.subscription_id_resources}/resourceGroups/${var.resourcegroup_name_agents}"
  location                  = var.location_agents
  schema_validation_enabled = false
  body = {
    kind = "AIServices",
    sku = {
      name = "S0"
    }
    identity = {
      type = "SystemAssigned"
    }
    properties = {
      # Support both Entra ID and API Key authentication for underlining Cognitive Services account
      disableLocalAuth = false

      # Specifies that this is an AI Foundry resource
      allowProjectManagement = true

      # Set custom subdomain name for DNS names created for this Foundry resource
      customSubDomainName = "aifoundry${random_string.unique.result}"

      # Network-related controls
      # Disable public access but allow Trusted Azure Services exception
      publicNetworkAccess = "Disabled"
      networkAcls = {
        defaultAction = "Allow"
      }

      # Enable VNet injection for Standard Agents
      networkInjections = [
        {
          scenario                   = "agent"
          subnetArmId                = azurerm_subnet.agents_subnet.id
          useMicrosoftManagedNetwork = false
        }
      ]
    }
  }
}


# ## Create a deployment for OpenAI's GPT-4o in the AI Foundry resource
# ##
resource "azurerm_cognitive_deployment" "aifoundry_deployment_gpt_4o" {
  provider = azurerm.infra_subscription
  depends_on = [
    azapi_resource.ai_foundry
  ]
  name                 = "gpt-4o"
  cognitive_account_id = azapi_resource.ai_foundry.id
  sku {
    name     = "GlobalStandard"
    capacity = 1
  }
  model {
    format  = "OpenAI"
    name    = "gpt-4o"
    version = "2024-11-20"
  }
}


# ## Create Private Endpoints for resources
# ##
resource "azurerm_private_endpoint" "pe_storage" {
  provider = azurerm.workload_subscription
  depends_on = [
    azurerm_storage_account.storage_account
  ]
  name                = "${azurerm_storage_account.storage_account.name}-private-endpoint"
  location            = var.location_agents
  resource_group_name = var.resourcegroup_name_resources
  subnet_id           = azurerm_subnet.resourcespe_subnet.id

  private_service_connection {
    name = "${azurerm_storage_account.storage_account.name}-private-link-service-connection"
    private_connection_resource_id = azurerm_storage_account.storage_account.id
    subresource_names = [
      "blob"
    ]
    is_manual_connection = false
  }

  private_dns_zone_group {
    name = "${azurerm_storage_account.storage_account.name}-dns-config"
    private_dns_zone_ids = [
      "/subscriptions/${var.subscription_id_infra}/resourceGroups/${var.resourcegroup_name_dns}/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
    ]
  }
}