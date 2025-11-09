## resource groups
variable "resourcegroup_name_agents" {
  description = "The name of the existing resource group where AI Foundry will be deployed"
  type        = string
}
variable "resourcegroup_name_resources" {
  description = "The name of the existing resource group where the Resources will be deployed"
  type        = string
}
variable "resourcegroup_name_networking" {
  description = "The name of the existing resource group where the Networking resources will be deployed"
  type        = string
}
variable "resourcegroup_name_dns" {
  description = "The name of the existing resource group where the DNS resources will be deployed"
  type        = string
}


## subscription ids
variable "subscription_id_agents" {
  description = "The subscription id where AI Foundry will be deployed"
  type        = string
}
variable "subscription_id_storage" {
  description = "The subscription id where Storage Account will be deployed"
  type        = string
}
variable "subscription_id_cosmosdb" {
  description = "The subscription id where Cosmos DB will be deployed"
  type        = string
}
variable "subscription_id_aisearch" {
  description = "The subscription id where AI Search will be deployed"
  type        = string
}
variable "subscription_id_networking" {
  description = "The subscription id where Networking will be deployed"
  type        = string
}

## locations
variable "location_agents" {
  description = "The name of the location to provision AI Foundry ato"
  type        = string
}
variable "location_storage" {
  description = "The name of the location to provision Storage Account to"
  type        = string
}
variable "location_cosmosdb" {
  description = "The name of the location to provision Cosmos DB to"
  type        = string
}
variable "location_aisearch" {
  description = "The name of the location to provision AI Search to"
  type        = string
}
variable "location_networking" {
  description = "The name of the location to provision Networking to"
  type        = string
}

## subnet names
variable "subnet_agents_name" {
 type = string
 description = "Subnet name for the agents"
}

variable "subnet_resourcespe_name" {
 type = string
 description = "Subnet name for the Private Endpoints of the resources"
}