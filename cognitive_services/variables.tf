variable "name" {
  description = "Name of the Cognitive Service name."
  type        = string
  default     = null
}


variable "kind" {
  type        = string
  description = "Specifies the kind of Cognitive Service Account to be created."

  validation {
    condition = contains([
      "AIServices", "Academic", "AnomalyDetector", "Bing.Autosuggest", "Bing.Autosuggest.v7", "Bing.CustomSearch",
      "Bing.Search", "Bing.Search.v7", "Bing.Speech", "Bing.SpellCheck", "Bing.SpellCheck.v7",
      "CognitiveServices", "ComputerVision", "ContentModerator", "ContentSafety", "CustomSpeech",
      "CustomVision.Prediction", "CustomVision.Training", "Emotion", "Face", "FormRecognizer",
      "ImmersiveReader", "LUIS", "LUIS.Authoring", "MetricsAdvisor", "OpenAI", "Personalizer",
      "QnAMaker", "Recommendations", "SpeakerRecognition", "Speech", "SpeechServices",
      "SpeechTranslation", "TextAnalytics", "TextTranslation", "WebLM"
    ], var.kind)
    error_message = "The provided 'cognitive_kind' is not a valid Cognitive Services kind."
  }
}


variable "sku_name" {
  type        = string
  description = "Specifies the SKU Name for the Cognitive Service Account."

  validation {
    condition = contains([
      "F0", "F1", "S0", "S", "S1", "S2", "S3", "S4", "S5", "S6",
      "P0", "P1", "P2", "E0", "DC0"
    ], var.sku_name)
    error_message = "Invalid SKU Name. Must be one of: F0, F1, S0, S, S1-S6, P0-P2, E0, DC0."
  }
}


variable "custom_subdomain_name" {
  type        = string
  description = <<EOT
(Optional) The subdomain name used for token-based authentication.
Required when:
  - `network_acls` is specified;
  - using the OpenAI service with libraries expecting endpoint like `https://<subdomain>.openai.azure.com/`.
Changing this value forces a new resource to be created.
EOT
  default     = null

  validation {
    condition = (
      var.custom_subdomain_name == null || can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$", var.custom_subdomain_name))
    )
    error_message = "Invalid subdomain name. Must be 3-64 characters, alphanumeric, may include hyphens (not at the start or end)."
  }
}


variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "Whether public network access is allowed for the Cognitive Account."
}


variable "location" {
  description = "Location of the Azure resources"
  type        = string
  default     = null
}


variable "resource_group_name" {
  description = "Name of the Resource Group, this is precreated resource group"
  type        = string
  default     = null
}


variable "resource_group" {
  type = object({
    name     = string
    location = string
    tags     = map(string)
  })
  description = "Predefined resource group object."
  default     = null
}


variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = null
}


variable "customer_managed_key" {
  type = object({
    key_vault_key_id   = string
    identity_client_id = optional(string)
  })
  description = <<-EOT
      key_vault_key_id   = (Required) The ID of the Key Vault Key which should be used
                           to Encrypt the data in this Cognitive Account.
      identity_client_id = (Optional) The Client ID of the User Assigned Identity that
                            has access to the key. This property only needs to be specified
                            when there're multiple identities attached to the Cognitive Account.
  EOT
  default     = null
}


variable "dynamic_throttling_enabled" {
  type        = bool
  description = "(Optional) Whether to enable the dynamic throttling for this Cognitive Service Account"
  default     = false
}


variable "fqdns" {
  type        = list(string)
  description = "(Optional) List of FQDNs allowed for the Cognitive Account."
  default     = null
}


variable "identity" {
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  description = <<-EOT
      type         = Required) Specifies the type of Managed Service Identity that should be
                     configured on this Cognitive Account. Possible values are
                     'SystemAssigned', 'UserAssigned', 'SystemAssigned, UserAssigned' (to enable both).
      identity_ids = (Optional) Specifies a list of User Assigned Managed Identity IDs to be
                     assigned to this Cognitive Account.
  EOT
  default     = null
}


# variable "identity_type" {
#   type        = string
#   default     = "SystemAssigned"
#   description = "Specifies the type of identity to assign to the resource. Possible values: SystemAssigned, UserAssigned, None."

#   validation {
#     condition     = contains(["SystemAssigned", "UserAssigned", "None"], var.identity_type)
#     error_message = "Identity type must be one of: SystemAssigned, UserAssigned, None."
#   }
# }


variable "network_acls" {
  type = set(object({
    bypass         = optional(string, null)
    default_action = string
    ip_rules       = optional(set(string))
    virtual_network_rules = optional(set(object({
      subnet_id                            = string
      ignore_missing_vnet_service_endpoint = optional(bool, false)
    })))
  }))
  description = <<-EOT
      bypass         = (Optional) Whether to allow trusted Azure Services to access the service.
                       Possible values are 'None' and 'AzureServices'.
                       NOTE:
                          'bypass' can only be set when 'kind' is set to 'OpenAI'
      default_action = (Required) The Default Action to use when no rules match from
                       'ip_rules' / 'virtual_network_rules'. Possible values are 'Allow' and 'Deny'.
      ip_rules       = (Optional) One or more IP Addresses, or CIDR Blocks which should be
                       able to access the Cognitive Account.
      virtual_network_rules = {
        subnet_id                            = (Required) The ID of the subnet which should be
                                               able to access this Cognitive Account.
        ignore_missing_vnet_service_endpoint = (Optional) Whether ignore missing
                                               vnet service endpoint or not. Default to 'false'.
      }
  EOT
  default     = null
}


variable "network_injection" {
  type = object({
    subnet_id = string
  })
  description = <<-EOT
    (Optional) Injects the AIServices account into a virtual network subnet.
    Only valid when 'kind' is set to 'AIServices'.
    subnet_id = (Required) The resource ID of the subnet to inject into.
  EOT
  default     = null
}


variable "local_auth_enabled" {
  type        = bool
  description = "(Optional) Whether local authentication methods is enabled for the Cognitive Account. Defaults to 'false'"
  default     = false
}


variable "project_management_enabled" {
  type        = bool
  description = <<-EOT
    (Optional) Whether project management is enabled when the kind is set to 'AIServices'.
    Once enabled, 'project_management_enabled' cannot be disabled.
    Changing this forces a new resource to be created.
    Defaults to false.
  EOT
  default     = null
}


variable "storage" {
  type = object({
    storage_account_id = string
    identity_client_id = optional(string, null)
  })
  description = <<-EOT
    storage_account_id = (Required) Full resource id of a Microsoft.Storage resource.
    identity_client_id = (Optional) The client ID of the managed identity associated with the storage resource.
  EOT
  default     = null
}
