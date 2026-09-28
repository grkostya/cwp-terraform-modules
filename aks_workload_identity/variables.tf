variable "identity_name" {
  type        = string
  description = "(Required) Specifies the name of this User Assigned Identity. Changing this forces a new User Assigned Identity to be created."
}


variable "resource_group" {
  type = object({
    name     = string
    location = string
    tags     = map(string)
  })
  description = <<-EOT
    name     = (Required) Specifies the name of the Resource Group within which this User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    location = (Required) The Azure Region where the User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created.
    tags     = (Optional) A mapping of tags to assign to the resource.
  EOT
  default     = null
}


variable "resource_group_name" {
  type        = string
  description = <<-EOT
    (Required) Specifies the name of the Resource Group within which this User Assigned Identity should exist.
    Changing this forces a new User Assigned Identity to be created.
  EOT
  default     = null
}


variable "location" {
  type        = string
  description = <<-EOT
    (Required) The Azure Region where the User Assigned Identity should exist.
    Changing this forces a new User Assigned Identity to be created.
  EOT
  default     = null
}


variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = null
}


variable "federated_credential" {
  type = object({
    oidc_issuer_url = string
    audience        = optional(list(string), ["api://AzureADTokenExchange"])
  })
  description = <<-EOT
    oidc_issuer_url = (Required) Specifies the issuer of this Federated Identity Credential.
    audience        = (Required) Specifies the audience for this Federated Identity Credential.
  EOT
  default     = null
}


variable "RBAC_roles" {
  type = map(object({
    scope     = string
    role_name = string
  }))
  description = <<-EOT
    scope     = (Required) The scope at which the Role Assignment applies to, such as
                '/subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333',
                '/subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup',
                or '/subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup/providers/Microsoft.Compute/virtualMachines/myVM',
                or '/providers/Microsoft.Management/managementGroups/myMG'.
                Changing this forces a new resource to be created.
    role_name = (Optional) The name of a built-in Role. Changing this forces a new resource to be created.
  EOT
  default     = {}
}


variable "create_k8s_service_account" {
  type        = bool
  description = "(Optional) Whether a Kubernetes service account should be created for the workload identity"
  default     = false
}


variable "k8s_service_account_name" {
  type        = string
  description = "(Optional) Name of the service account, must be unique."
  default     = null
}


variable "k8s_namespace" {
  type        = string
  description = "(Optional) Namespace defines the space within which name of the service account must be unique."
  default     = "default"
}


variable "k8s_annotations" {
  type        = map(string)
  description = "(Optional) An unstructured key value map stored with the service account that may be used to store arbitrary metadata."
  default     = {}
}


variable "k8s_labels" {
  type        = map(string)
  description = "(Optional) Map of string keys and values that can be used to organize and categorize (scope and select) the service account. May match selectors of replication controllers and services."
  default     = {}
}


variable "federation_name" {
  type        = string
  description = <<-EOT
      (Optional) The name of the Federated Identity Credential.
      If not specified, the name will be derived from the 'k8s_service_account_name' name.
  EOT
  default     = null
}
