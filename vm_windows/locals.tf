locals {
  resource_group_name = coalesce(var.resource_group_name, try(var.resource_group.name, null))

  location = coalesce(var.location, try(var.resource_group.location, null))

  provision_vm_agent = (var.patch_assessment_mode == "AutomaticByPlatform" || var.patch_mode == "AutomaticByPlatform") ? true : false

  # computer_name = format("%.15s", replace(coalesce(var.computer_name, var.vm_name), "-", ""))
  computer_name = format("%.15s", coalesce(var.computer_name, var.vm_name))
}
