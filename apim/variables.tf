variable "apim_name" {
  description = "The name of the API Management service"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "publisher_name" {
  description = "The name of the publisher"
  type        = string
  default     = "EnergyAI"
}

variable "publisher_email" {
  description = "The email of the publisher"
  type        = string
  default     = "energyai@inceptionai.ai"
}

variable "sku_name" {
  description = "The SKU name of the API Management service"
  type        = string
  default     = "Developer_1"
}

variable "subnet_id" {
  description = "The ID of the subnet for APIM"
  type        = string
}

variable "virtual_network_type" {
  description = "The type of virtual network"
  type        = string
  default     = "Internal"
}

variable "key_vault_id" {
  description = "The ID of the Key Vault"
  type        = string
}

variable "key_vault_uri" {
  description = "The URI of the Key Vault"
  type        = string
}

# API Configurations
variable "apis" {
  description = "Map of API configurations"
  type = map(object({
    name                  = string
    display_name          = string
    path                  = string
    protocols             = list(string)
    service_url           = optional(string)
    subscription_required = bool
    openapi_spec_file     = optional(string)
    policy_file           = optional(string)
    subscription_key_parameter_names = optional(object({
      header = string
      query  = string
    }))
  }))
  default = {}
}


# Backend Configurations
variable "backends" {
  description = "Map of backend configurations"
  type = map(object({
    name     = string
    url      = string
    protocol = string
    credentials = optional(object({
      header = optional(map(list(string)))
      query  = optional(map(string))
      authorization = optional(object({
        scheme    = string
        parameter = string
      }))
    }))
    tls = optional(object({
      validate_certificate_chain = bool
      validate_certificate_name  = bool
    }))
  }))
  default = {}
}

# Subscription Configurations
variable "subscriptions" {
  description = "Map of subscription configurations"
  type = map(object({
    name         = string
    display_name = string
    api_name     = optional(string)
    state        = string
  }))
  default = {}
}

# Logger Configurations
variable "loggers" {
  description = "Map of logger configurations"
  type = map(object({
    name        = string
    type        = string
    resource_id = optional(string)
    credentials = optional(map(string))
    buffered    = optional(bool)
  }))
  default = {}
}

# Diagnostic Configurations
variable "diagnostics" {
  description = "Map of diagnostic configurations"
  type = map(object({
    api_name            = optional(string)
    identifier          = string
    logger_name         = string
    sampling_percentage = number
  }))
  default = {}
}

# Named Values Configurations
variable "named_values" {
  description = "Map of named value configurations"
  type = map(object({
    name             = string
    display_name     = string
    secret           = bool
    key_vault_secret = bool
  }))
  default = {}
}

# User Configurations
variable "users" {
  description = "Map of user configurations"
  type = map(object({
    user_id    = string
    email      = string
    first_name = string
    last_name  = string
    state      = string
  }))
  default = {}
}
