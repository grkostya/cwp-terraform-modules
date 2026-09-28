resource "azurerm_network_interface" "this" {
  name                = "nic-${var.vm_name}"
  location            = local.location
  resource_group_name = local.resource_group_name
  tags                = local.tags

  ip_configuration {
    name                          = "default"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address_id
  }
}




resource "azurerm_windows_virtual_machine" "this" {
  name                  = var.vm_name
  location              = local.location
  resource_group_name   = local.resource_group_name
  tags                  = local.tags
  network_interface_ids = [azurerm_network_interface.this.id]
  size                  = var.vm_size

  source_image_reference {
    publisher = var.os_image.publisher
    offer     = var.os_image.offer
    sku       = var.os_image.sku
    version   = var.os_image.version
  }
  os_disk {
    name                   = "OS_Disk_${var.vm_name}"
    disk_size_gb           = var.os_disk_size_gb
    caching                = "ReadWrite"
    storage_account_type   = "Standard_LRS"
    disk_encryption_set_id = var.disk_encryption_set_id
  }

  computer_name  = local.computer_name
  admin_username = var.admin_username
  admin_password = var.admin_password

  identity {
    type = "SystemAssigned"
  }

  # cloud-init
  custom_data = var.custom_data

  secure_boot_enabled        = var.secure_boot_enabled
  encryption_at_host_enabled = var.encryption_at_host_enabled

  patch_assessment_mode      = var.patch_assessment_mode
  patch_mode                 = var.patch_mode
  provision_vm_agent         = local.provision_vm_agent
  allow_extension_operations = local.provision_vm_agent
}
