
resource "azurerm_linux_virtual_machine" "VM" {
  name                = var.virtual_machine_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_F2"
  # admin_username      = data.azurerm_key_vault_secret.secret_username.value
  # admin_password      = data.azurerm_key_vault_secret.secret_password.value
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  disable_password_authentication = "false"
  network_interface_ids = [data.azurerm_network_interface.nic.id]
  # network_interface_ids              = [var.network_interface_id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
    custom_data = base64encode(<<EOF
#!/bin/bash
sudo apt update
sudo apt install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
EOF
  )
}
