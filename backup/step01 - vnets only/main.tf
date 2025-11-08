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