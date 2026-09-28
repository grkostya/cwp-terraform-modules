locals {
  env = lower(coalesce(var.environment, terraform.workspace))

  subnet_name_suffix = var.subnet_name_suffix == null ? "enai-${local.env}-aen-01" : var.subnet_name_suffix
}
