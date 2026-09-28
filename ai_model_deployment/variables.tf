variable "cognitive_account_id" {
  description = "The ID of the Cognitive Services Account"
  type        = string
}


variable "name" {
  description = "The name of the Cognitive Deployment"
  type        = string
}


variable "rai_policy_name" {
  type        = string
  description = "The name of the RAI policy. Options: 'Microsoft.Default', 'Microsoft.DefaultV2'"
  default     = "Microsoft.DefaultV2"
}


variable "version_upgrade_option" {
  type        = string
  description = <<-EOT
    (Optional) Deployment model version upgrade option. Possible values are
    'OnceNewDefaultVersionAvailable', 'OnceCurrentVersionExpired', and 'NoAutoUpgrade'.
    Defaults to 'OnceNewDefaultVersionAvailable'.
  EOT
  default     = "OnceNewDefaultVersionAvailable"
}


variable "model" {
  type = object({
    format  = optional(string, "OpenAI")
    name    = string
    version = optional(string)
  })
  description = <<-EOT
    format  = (Required) The format of the Cognitive Services Account Deployment model.
              Changing this forces a new resource to be created. Possible value is 'OpenAI'.
    name    = (Required) The name of the model.
    version = (Optional) The version of Cognitive Services Account Deployment model.
              If version is not specified, the default version of the model at the time
              will be assigned.
  EOT
}


variable "sku" {
  type = object({
    name     = string
    tier     = optional(string)
    size     = optional(string)
    family   = optional(string)
    capacity = optional(number, 1)
  })
  description = <<-EOT
    name     = (Required) The name of the SKU. Possible values include
               'Standard', 'DataZoneBatch', 'DataZoneStandard', 'DataZoneProvisionedManaged',
               'GlobalBatch', 'GlobalProvisionedManaged', 'GlobalStandard', and 'ProvisionedManaged'.
        NOTE:
            'DataZoneProvisionedManaged', 'GlobalProvisionedManaged', and 'ProvisionedManaged'
            are purchased on-demand at an hourly basis based on the number of deployed PTUs,
            with substantial term discount available via the purchase of Azure Reservations.
            Currently, this step cannot be completed using Terraform.
            For more details, please refer to the provisioned throughput onboarding documentation(https://learn.microsoft.com/en-us/azure/ai-services/openai/how-to/provisioned-throughput-onboarding).
    tier     = (Optional) Possible values are 'Free', 'Basic', 'Standard', 'Premium', 'Enterprise'.
               This property is required only when multiple tiers are available with the SKU name.
               Changing this forces a new resource to be created.
    size     = (Optional) The SKU size. When the name field is the combination of
               tier and some other value, this would be the standalone code.
               Changing this forces a new resource to be created.
    family   = (Optional) If the service has different generations of hardware,
               for the same SKU, then that can be captured here.
               Changing this forces a new resource to be created.
    capacity = (Optional) Tokens-per-Minute (TPM). The unit of measure for this field is
               in the thousands of Tokens-per-Minute. Defaults to '1' which means that
               the limitation is 1000 tokens per minute. If the resources SKU supports
               scale in/out then the capacity field should be included in the resources' configuration.
               If the scale in/out is not supported by the resources SKU then this field can be
               safely omitted. For more information about TPM please see the product documentation(https://learn.microsoft.com/azure/ai-services/openai/how-to/quota?tabs=rest).
  EOT
}
