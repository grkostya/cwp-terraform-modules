locals {
  app_code          = lower(var.application_code)
  env               = lower(var.environment)
  subscription_code = lower(var.subscription_code)
  location          = lower(var.location.short_name)
  name_suffix       = join("-", compact([local.app_code, local.subscription_code, local.env, local.location, var.number]))
  name_suffix_safe  = lower(replace(local.name_suffix, "-", ""))

  # random_safe_generation  = join("", [random_string.first_letter.result, random_string.main.result])
  # random                  = substr(coalesce(var.unique-seed, local.random_safe_generation), 0, var.unique-length)
  random                  = substr(coalesce(var.unique-seed, module.naming.unique-seed), 0, var.unique-length)
  name_suffix_unique      = join("-", [local.name_suffix, local.random])
  name_suffix_unique_safe = join("", [local.name_suffix_safe, local.random])
}
