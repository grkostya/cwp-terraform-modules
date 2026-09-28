variable "name_suffix" {
  type        = string
  description = "(Required) Specifies the name suffix of the resource. Changing this forces a new resource to be created."
}


variable "resource_group" {
  type = object({
    name     = string
    location = string
    tags     = map(string)
    id       = string
  })
  description = <<-EOT
    name     = The name of the resource group.
    location = The location/region where the resource group is created.
    tags     = A mapping of tags to assign to the resource.
    id       = The ID of the resource group.
  EOT
  default     = null
}


variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the resource. Changing this forces a new resource to be created."
  default     = null
}


variable "resource_group_id" {
  type        = string
  description = "(Required) The ID of the resource group in which to create the resource. Changing this forces a new resource to be created."
  default     = null
}


variable "location" {
  type        = string
  description = "(Required) The location/region where the resource is created. Changing this forces a new resource to be created."
  default     = null
}


variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = null
}


variable "sku" {
  type        = string
  description = "The sku name of the Azure Analysis Services server to create. Choose from: B1, B2, D1, S0, S1, S2, S3, S4, S8, S9. Some skus are region specific. See https://docs.microsoft.com/en-us/azure/analysis-services/analysis-services-overview#availability-by-region"
  default     = "S0"
}


variable "storage_account_id" {
  type        = string
  description = "The ID of the storage account to use for the AI Foundry."
}


variable "key_vault_id" {
  type        = string
  description = "The ID of the key vault to use for the AI Foundry."
}


variable "cmk_keyvault_key_uri" {
  type        = string
  description = "Key vault uri to access the encryption key."
  default     = null
}


variable "cmk_client_id" {
  type        = string
  description = "The client ID of the User-Assigned Identity to assign to the resource."
  default     = null
}


variable "user_assigned_identity_id" {
  type        = string
  description = "The ID of the User-Assigned Identity to assign to the resource."
  default     = null
}


# New variables for optional configurations (AI generated)
variable "custom_subdomain_name" {
  description = "The subdomain name used for token-based authentication."
  type        = string
  default     = null
}

variable "fqdns" {
  description = "List of FQDNs allowed for the AI Services Account."
  type        = list(string)
  default     = null
}

variable "local_authentication_enabled" {
  description = "Whether local authentication is enabled for the AI Services Account."
  type        = bool
  default     = true
}

variable "outbound_network_access_restricted" {
  description = "Whether outbound network access is restricted for the AI Services Account."
  type        = bool
  default     = false
}

variable "public_network_access" {
  description = "Whether public network access is allowed for the AI Services Account."
  type        = string
  default     = "Enabled"
}

variable "network_acls" {
  description = "A network_acls block to configure network rules."
  type = object({
    default_action = string
    ip_rules       = list(string)
    virtual_network_rules = list(object({
      subnet_id                            = string
      ignore_missing_vnet_service_endpoint = bool
    }))
  })
  default = null
}

variable "storage" {
  description = "A storage block to configure storage settings."
  type = object({
    storage_account_id = string
    identity_client_id = string
  })
  default = null
}

variable "identity" {
  description = "An identity block to configure Managed Service Identity."
  type = object({
    type         = string
    identity_ids = list(string)
  })
  default = null
}
