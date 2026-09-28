locals {
  resource_group_name = coalesce(var.resource_group_name, try(var.resource_group.name, null))
  location            = coalesce(var.location, try(var.resource_group.location, null))

  created_plan_id          = var.create_service_plan && length(azurerm_service_plan.this) > 0 ? azurerm_service_plan.this[0].id : null
  computed_service_plan_id = coalesce(var.existing_app_service_plan_id, local.created_plan_id)

  # Flag indicating if Application Insights should be created.
  create_app_insights = var.app_insights_name != "" && var.application_insights_external.connection_string == "" && var.application_insights_external.instrumentation_key == ""

  # Count for the Application Insights resource.
  ai_count = local.create_app_insights ? 1 : 0

  # Compute the Application Insights connection string.
  computed_ai_connection_string = var.application_insights_external.connection_string != "" ? var.application_insights_external.connection_string : (local.create_app_insights ? try(azurerm_application_insights.this[0].connection_string, null) : null)

  # Compute the Application Insights instrumentation key.
  computed_ai_key = var.application_insights_external.instrumentation_key != "" ? var.application_insights_external.instrumentation_key : (local.create_app_insights ? try(azurerm_application_insights.this[0].instrumentation_key, null) : null)
}
