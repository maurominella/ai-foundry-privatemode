# Configure Private DNS Zones for various Azure services
resource "azurerm_private_dns_zone" "blob_dns_zone" {
  provider = azurerm.infra_subscription
  
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_group_name_dns
}

resource "azurerm_private_dns_zone" "documents_dns_zone" {
  provider = azurerm.infra_subscription
  
  name                = "privatelink.documents.azure.com"
  resource_group_name = var.resource_group_name_dns
}

resource "azurerm_private_dns_zone" "search_dns_zone" {
  provider = azurerm.infra_subscription
  
  name                = "privatelink.search.windows.net"
  resource_group_name = var.resource_group_name_dns
}

resource "azurerm_private_dns_zone" "cognitiveservices_dns_zone" {
  provider = azurerm.infra_subscription
  
  name                = "privatelink.cognitiveservices.azure.com"
  resource_group_name = var.resource_group_name_dns
}

resource "azurerm_private_dns_zone" "openai_dns_zone" {
  provider = azurerm.infra_subscription
  
  name                = "privatelink.openai.azure.com"
  resource_group_name = var.resource_group_name_dns
}

resource "azurerm_private_dns_zone" "services_ai_dns_zone" {
  provider = azurerm.infra_subscription
  
  name                = "privatelink.services.ai.azure.com"
  resource_group_name = var.resource_group_name_dns
}

resource "azurerm_private_dns_zone_virtual_network_link" "blob_dns_zone_vnet_link" {
  provider = azurerm.infra_subscription
  
  name                  = "blob-dns-vnet-link-${random_string.unique.result}"
  resource_group_name   = var.resource_group_name_dns
  private_dns_zone_name = azurerm_private_dns_zone.blob_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "documents_dns_zone_vnet_link" {
  provider = azurerm.infra_subscription
  
  name                  = "documents-dns-vnet-link-${random_string.unique.result}"
  resource_group_name   = var.resource_group_name_dns
  private_dns_zone_name = azurerm_private_dns_zone.documents_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "search_dns_zone_vnet_link" {
  provider = azurerm.infra_subscription
  
  name                  = "search-dns-vnet-link-${random_string.unique.result}"
  resource_group_name   = var.resource_group_name_dns
  private_dns_zone_name = azurerm_private_dns_zone.search_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "cognitiveservices_dns_zone_vnet_link" {
  provider = azurerm.infra_subscription
  
  name                  = "cognitiveservices-dns-vnet-link-${random_string.unique.result}"
  resource_group_name   = var.resource_group_name_dns
  private_dns_zone_name = azurerm_private_dns_zone.cognitiveservices_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "openai_dns_zone_vnet_link" {
  provider = azurerm.infra_subscription
  
  name                  = "openai-dns-vnet-link-${random_string.unique.result}"
  resource_group_name   = var.resource_group_name_dns
  private_dns_zone_name = azurerm_private_dns_zone.openai_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "services_ai_dns_zone_vnet_link" {
  provider = azurerm.infra_subscription
  
  name                  = "services-ai-dns-vnet-link-${random_string.unique.result}"
  resource_group_name   = var.resource_group_name_dns
  private_dns_zone_name = azurerm_private_dns_zone.services_ai_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}