# Configure Private DNS Zones for various Azure services
resource "azurerm_private_dns_zone" "blob_dns_zone" {
  provider = azurerm.infra_subscription
  
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resourcegroup_name_dns
}

resource "azurerm_private_dns_zone_virtual_network_link" "blob_dns_zone_vnet_link" {
  provider = azurerm.infra_subscription
  
  name                  = "blob-dns-vnet-link-${random_string.unique.result}"
  resource_group_name   = var.resourcegroup_name_dns
  private_dns_zone_name = azurerm_private_dns_zone.blob_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}