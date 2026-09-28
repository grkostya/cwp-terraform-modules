output "azure" {
  value = module.naming
}


output "name_suffix" {
  value = local.name_suffix
}


output "custom" {
  value = local.az
}


output "networking" {
  value = local.networking
}


output "unique-seed" {
  value = local.random
}


output "application_code" {
  value = var.application_code
}


output "subscription_code" {
  value = var.subscription_code
}


output "location" {
  value = var.location
}


output "number" {
  value = var.number
}
