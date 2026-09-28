variable "application_code" {
  type        = string
  description = <<-EOT
    The part of the naming convention that specifies the purpose of an application or service.
  EOT
  default     = ""
}


variable "environment" {
  type        = string
  description = <<-EOT
    The abbreviation of an environment name.
    Possible values are 'dev', 'uat', 'stg', 'ppr', 'prd', 'tst', 'shr', 'trn', 'dbg', 'dem', 'sec', 'hub'.
  EOT

  validation {
    condition     = contains(["dev", "uat", "stg", "ppr", "prd", "tst", "shr", "trn", "dbg", "dem", "sec", "hub"], lower(var.environment))
    error_message = <<-EOT
    Invalid environment name.
    Valid options are 'dev', 'uat', 'stg', 'ppr', 'prd', 'tst', 'shr', 'trn', 'dbg', 'dem', 'sec', 'hub'.
    EOT
  }
}


variable "subscription_code" {
  type        = string
  default     = "nrgi"
  description = "The short code of a subscription."
}


variable "number" {
  type    = string
  default = "001"
}


variable "location" {
  type = object({
    name       = string
    short_name = string
  })
  description = <<-EOT
    name       = (Required) The Azure Region where resources should exist.
                 Changing this forces a new resource to be created.
    short_name = The Azure Region Abbreviation. Will be used as a part of a resource name
                 according to the naming convention.
  EOT
  default = {
    name       = "northeurope"
    short_name = "neu"
  }
}


variable "unique-include-numbers" {
  description = "Whether to include numbers in the unique generation."
  type        = bool
  default     = true
}


variable "unique-seed" {
  description = "Custom value for the random characters to be used."
  type        = string
  default     = ""
}


variable "unique-length" {
  description = "Max length of the uniqueness suffix to be added."
  type        = number
  default     = 4
}
