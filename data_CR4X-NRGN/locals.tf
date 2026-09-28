locals {
  env = lower(coalesce(var.environment, terraform.workspace))
}
