variable "resource_group_name_resources" {
  description = "The name of the existing resource group where the AI Foundry dependencies will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the existing resource group where AI Foundry will be deployed"
  type        = string
}

variable "resource_group_name_dns" {
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

variable "location_resources" {
  description = "The name of the location to provision AI Foundry dependencies to"
  type        = string
}

variable "location" {
  description = "The name of the location to provision Networking and AI Foundry to"
  type        = string
}

