module "CosmosDB_MongoDB" {
  source = "../../../modules/cosmosdb"

  name           = module.naming.azure.cosmosdb_account.name
  resource_group = azurerm_resource_group.this

  kind = "MongoDB"

  mongo_server_version = "7.0"

  ## CMK Encryption
  encryption_key            = azurerm_key_vault_key.Encryption
  user_assigned_identity_id = azurerm_user_assigned_identity.Encryption.id

  #   create_mongodb_database = true        ## Default: false
  #   mongodb_database_name   = "energyai"  ## Default: "database"
  #   database_throughput     = 1000        ## Default: 400
  #   mongodb_collections = [
  #     {
  #       name = "chats"
  #     #   throughput = 400  ## Default: 400
  #       index = [
  #         {
  #           keys   = ["_id"]
  #           unique = true ## Default: false
  #         },
  #         {
  #           keys = ["timestamp"]
  #         },
  #       ]
  #     },
  #   ]

  capabilities = [
    { name = "EnableMongo" },
    { name = "EnableMongoRoleBasedAccessControl" },
  ]
}




module "Private_Endpoint_CosmosDB_MongoDB" {
  source = "../../../modules/private_endpoint"

  resource_group              = azurerm_resource_group.this
  private_connection_resource = module.CosmosDB_MongoDB
  subresource_names           = ["MongoDB"]
  subnet_id                   = data.azurerm_subnet.Private_Endpoints.id
  private_dns_zone_ids        = [data.azurerm_private_dns_zone.CosmosDB_MongoDB.id]
}
