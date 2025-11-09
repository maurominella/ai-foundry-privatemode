variable "resourcegroup_name_agents" {
  description = "The name of the existing resource group where AI Foundry will be deployed"
  type        = string
}

variable "resourcegroup_name_resources" {
  description = "The name of the existing resource group where the AI Foundry dependencies will be deployed"
  type        = string
}

variable "resourcegroup_name_dns" {
  description = "The name of the existing resource group where the Private DNS Zones will be deployed"
  type        = string
}

variable "subscription_id_infra" {
  description = "The subscription id where Networking and AI Foundry will be deployed"
  type        = string
}

variable "subscription_id_resources" {
  description = "The subscription id where the AI Foundry dependencies will be deployed"
  type        = string
}

variable "location_agents" {
  description = "The name of the location to provision AI Foundry andNetworking to"
  type        = string
}

variable "location_resources" {
  description = "The name of the location to provision AI Foundry dependencies to"
  type        = string
}

variable "subnet_agents_name" {
 type = string
 description = "Subnet name for the agents"
}

variable "subnet_resourcespe_name" {
 type = string
 description = "Subnet name for the Private Endpoints of the resources"
}