variable "resource_group" {
  type = object({
    name     = string
    location = string
    tags     = map(string)
  })
  description = <<-EOT
    name     = (Required) The name of the resource group in which to create the CosmosDB Account. Changing this forces a new resource to be created.
    location = (Required) The location/region where CosmosDB Account host is created. Changing this forces a new resource to be created.
    tags     = (Optional) A mapping of tags to assign to the resource.
  EOT
  default     = null

  validation {
    condition     = var.resource_group != null || (var.resource_group_name != null && var.location != null)
    error_message = <<-EOT
      Input is required:
      Provide either the 'resource_group' object or the values for 'resource_group_name' and 'location'
    EOT
  }
}


variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the CosmosDB Account. Changing this forces a new resource to be created."
  default     = null
}


variable "location" {
  type        = string
  description = "(Required) The location/region where to create the CosmosDB Account. Changing this forces a new resource to be created."
  default     = null
}


variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = null
}


variable "name" {
  type        = string
  description = "(Required) Specifies the name of the CosmosDB Account. Changing this forces a new resource to be created."
}


variable "default_identity_type" {
  type        = string
  description = <<-EOT
    (Optional) The default identity for accessing Key Vault.
    Possible values are 'FirstPartyIdentity', 'SystemAssignedIdentity' or 'UserAssignedIdentity'.
    Defaults to 'SystemAssignedIdentity' (Originally 'FirstPartyIdentity')
    NOTE:
      When 'default_identity_type' is a 'UserAssignedIdentity' it must include
      the User Assigned Identity ID in the following format:
        UserAssignedIdentity=/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{userAssignedIdentityName}
    EOT
  default     = "SystemAssignedIdentity"
}


variable "user_assigned_identity_id" {
  type        = string
  description = "(Optional) The User Assigned Managed Identity ID to be assigned to this Cosmos Account."
  default     = null
}


variable "encryption_key" {
  type = object({
    id             = string
    key_vault_id   = string
    versionless_id = string
  })
  description = <<-EOT
    id             = A Key Vault Key ID for CMK encryption.
    key_vault_id   = The ID of the Key Vault where the Key is created. Changing this forces a new resource to be created.
    versionless_id = A versionless Key Vault Key ID for CMK encryption. Changing this forces a new resource to be created.
      NOTE:
        - When referencing an 'azurerm_key_vault_key' resource, use 'versionless_id' instead of 'id'
        - In order to use a Custom Key from Key Vault for encryption you must grant Azure Cosmos DB Service
          access to your key vault. For instructions on how to configure your Key Vault correctly
          please refer to the product documentation (https://docs.microsoft.com/azure/cosmos-db/how-to-setup-cmk#add-an-access-policy-to-your-azure-key-vault-instance).
  EOT
  default = {
    id             = null
    key_vault_id   = null
    versionless_id = null
  }
}


variable "kind" {
  type        = string
  description = <<-EOT
     (Optional) Specifies the Kind of CosmosDB to create.
     Possible values are 'GlobalDocumentDB', 'MongoDB' and 'Parse'. Defaults to 'GlobalDocumentDB'.
     Changing this forces a new resource to be created.
  EOT
  default     = "GlobalDocumentDB"
}


variable "automatic_failover_enabled" {
  type        = bool
  description = "(Optional) Enable automatic failover for this Cosmos DB account."
  default     = false
}


variable "consistency_policy" {
  type = object({
    consistency_level       = string
    max_interval_in_seconds = number
    max_staleness_prefix    = number
  })
  description = <<-EOT
    consistency_level       = (Required) The Consistency Level to use for this CosmosDB Account.
                              Can be either 'BoundedStaleness', 'Eventual', 'Session', 'Strong' or 'ConsistentPrefix'.
    max_interval_in_seconds = (Optional) When used with the Bounded Staleness consistency level,
                              this value represents the time amount of staleness (in seconds) tolerated.
                              The accepted range for this value is 5 - 86400 (1 day).
                              Defaults to 5. Required when 'consistency_level' is set to 'BoundedStaleness'.
    max_staleness_prefix    = (Optional) When used with the Bounded Staleness consistency level,
                              this value represents the number of stale requests tolerated.
                              The accepted range for this value is 10 – 2147483647.
                              Defaults to 100. Required when 'consistency_level' is set to 'BoundedStaleness'.
                        NOTE:
                            'max_interval_in_seconds' and 'max_staleness_prefix' can only be set to values
                            other than default when the 'consistency_level' is set to 'BoundedStaleness'.
  EOT
  default = {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
}


variable "backup" {
  type = object({
    type = optional(string, "Continuous")
    tier = string
  })
  description = <<-EOT
      type = (Required) The type of the backup. Possible values are 'Continuous' and 'Periodic'.
             NOTE:
                  Migration of 'Periodic' to 'Continuous' is one-way,
                  changing 'Continuous' to 'Periodic' forces a new resource to be created.
      tier = (Optional) The continuous backup tier. Possible values are 'Continuous7Days' and 'Continuous30Days'.
    EOT
  default = {
    type = "Continuous"
    tier = "Continuous7Days"
  }
}


variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Whether or not public network access is allowed for this CosmosDB account. Defaults to 'false'."
  default     = false
}


variable "local_authentication_disabled" {
  type        = bool
  description = <<-EOT
    (Optional) Disable local authentication and ensure only MSI and AAD can be used
    exclusively for authentication. Defaults to 'false'.
    Can be set only when using the SQL API.
  EOT
  default     = false
}


variable "AzureCosmosDB_oid" {
  type        = string
  description = <<-EOT
    The 'Azure Cosmos DB' first-party-identity object ID.
    NOTE:
      You can search the 'Azure Cosmos DB' first-party-identity by the name or application ID:
      00001111-aaaa-2222-bbbb-3333cccc4444 for any Azure region except Azure Government regions
      where the application ID is 11112222-bbbb-3333-cccc-4444dddd5555.
      If the 'Azure Cosmos DB' principal isn't in the list, you might need to re-register
      the 'Microsoft.DocumentDB' resource provider.
  EOT
  default     = ""
}


variable "capabilities" {
  type = list(object({
    name = string
  }))
  description = <<-EOT
    A capabilities block Configures the capabilities to be enabled for this Cosmos DB account:

    name = (Required) The capability to enable. Possible values are
           'AllowSelfServeUpgradeToMongo36', 'DisableRateLimitingResponses', 'EnableAggregationPipeline',
           'EnableCassandra', 'EnableGremlin', 'EnableMongo', 'EnableMongo16MBDocumentSupport',
           'EnableMongoRetryableWrites', 'EnableMongoRoleBasedAccessControl', 'EnableNoSQLVectorSearch',
           'EnableNoSQLFullTextSearch', 'EnablePartialUniqueIndex', 'EnableServerless', 'EnableTable',
           'EnableTtlOnCustomPath', 'EnableUniqueCompoundNestedDocs', 'MongoDBv3.4' and 'mongoEnableDocLevelTTL'.
      NOTE:
          - Setting 'MongoDBv3.4' also requires setting 'EnableMongo'.
          - Only 'AllowSelfServeUpgradeToMongo36', 'DisableRateLimitingResponses', 'EnableAggregationPipeline',
            'MongoDBv3.4', 'EnableMongoRetryableWrites', 'EnableMongoRoleBasedAccessControl',
            'EnableUniqueCompoundNestedDocs', 'EnableMongo16MBDocumentSupport', 'mongoEnableDocLevelTTL',
            'EnableTtlOnCustomPath' and 'EnablePartialUniqueIndex' can be added to an existing Cosmos DB account.
          - Only 'DisableRateLimitingResponses' and 'EnableMongoRetryableWrites' can be removed from
             an existing Cosmos DB account.
  EOT
  default     = []
}




## SQL
variable "create_sql_database" {
  type        = bool
  description = "Whether to create a SQL database."
  default     = false
}


variable "sql_database_name" {
  type        = string
  description = "Specifies the name of the Cosmos DB SQL Database."
  default     = "database"
}


variable "sql_database_containers" {
  type = map(object({
    # name - the map key will be used as the name
    partition_key_paths = optional(list(string), ["/id"])
    throughput          = optional(number, 400)
  }))
  description = <<-EOT
      (Optional) The list of container names to create.
      name (map key)      = (Required) Specifies the name of the Cosmos DB SQL Container.
                            Changing this forces a new resource to be created.
      partition_key_paths = (Required) A list of partition key paths.
                            Changing this forces a new resource to be created. Defaults to ["/id"].
      throughput          = (Optional) The throughput of the SQL container (RU/s). Must be set in increments of 100.
                            The minimum value is 400. This must be set upon container creation otherwise
                            it cannot be updated without a manual terraform destroy-apply.
  EOT
  default     = {}
}




## MongoDB
variable "mongo_server_version" {
  type        = string
  description = "(Optional) The Server Version of a MongoDB account. Possible values are 7.0, 6.0, 5.0, 4.2, 4.0, 3.6, and 3.2."
  default     = null
}


variable "create_mongodb_database" {
  type        = bool
  description = "Whether to create a MongoDB database."
  default     = false
}


variable "mongodb_database_name" {
  type        = string
  description = "Specifies the name of the Cosmos DB MongoDB Database."
  default     = "database"
}


variable "database_throughput" {
  type        = string
  description = <<-EOT
    (Optional) The throughput of the MongoDB database (RU/s). Must be set in increments of 100.
    The minimum value is 400. This must be set upon database creation otherwise
    it cannot be updated without a manual terraform destroy-apply.
  Note:
    'throughput' has a maximum value of 1000000 unless a higher limit is requested
    via Azure Support.
  EOT
  default     = 400
}


variable "mongodb_collections" {
  type = list(object({
    name                = string
    default_ttl_seconds = optional(number)
    shard_key           = optional(string)
    throughput          = optional(number, 400)
    index = optional(list(object({
      keys   = list(string)
      unique = optional(bool, false)
    })), [{ keys = ["_id"], unique = true }])
  }))
  description = <<-EOT
    (Optional) The list of MongoDB collection objects to create.
    name                = (Required) Specifies the name of the Cosmos DB Mongo Collection.
                           Changing this forces a new resource to be created.
    default_ttl_seconds = (Optional) The default Time To Live in seconds.
                           If the value is -1, items are not automatically expired.
    shard_key           = (Optional) The name of the key to partition on for sharding.
                           There must not be any other unique index keys. Changing this forces a new resource
                           to be created.
    throughput          = (Optional) The throughput of the MongoDB collection (RU/s). Must be set in
                           increments of 100. The minimum value is 400. This must be set upon database creation
                           otherwise it cannot be updated without a manual terraform destroy-apply.
    index_keys          = (Required) Specifies the list of user settable keys for each Cosmos DB Mongo Collection.
    index_unique        = (Optional) Is the index unique or not? Defaults to 'false'.
  EOT
  default     = []
}
