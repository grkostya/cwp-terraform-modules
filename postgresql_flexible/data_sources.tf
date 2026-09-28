data "azuread_user" "db_admins" {
  for_each  = try(var.default_database_administrator_object_ids["User"], {})
  object_id = each.key
}


data "azuread_group" "db_admins" {
  for_each  = try(var.default_database_administrator_object_ids["Group"], {})
  object_id = each.key
}


data "azuread_service_principal" "db_admins" {
  for_each  = try(var.default_database_administrator_object_ids["ServicePrincipal"], {})
  object_id = each.key
}


data "azurerm_client_config" "current" {}
