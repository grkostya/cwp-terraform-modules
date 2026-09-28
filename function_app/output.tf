output "id" {
  description = "ID of the created Function App"
  value       = azurerm_linux_function_app.this.id
}
output "name" {
  description = "Name of the created Function App"
  value       = azurerm_linux_function_app.this.name
}
output "principal_id" {
  value = azurerm_linux_function_app.this.identity[0].principal_id
}

# Output the Application Insights instrumentation key.
output "instrumentation_key" {
  value = local.computed_ai_key
}

output "app_insights_id" {
  value = local.create_app_insights ? try(azurerm_application_insights.this[0].app_id, null) : null
}

output "service_plan_id" {
  value = local.computed_service_plan_id
}
