module "azurerm_resource_group" {
  source              = "../module/azurerm_resource_group"
  resource_group_name = "soumya-rg"
  location            = "West Europe"
}

module "azurerm_virtual_network" {
  source                       = "../module/azurerm_virtual_network"
  azurerm_virtual_network_name = "soumya-vnet"
  location                     = "West Europe"
  resource_group_name          = "soumya-rg"
  address_space                = ["10.0.0.0/16"]
  depends_on                   = [module.azurerm_resource_group]
}

module "azurerm_frontend_subnet" {
  source               = "../module/azurerm_subnet"
  azurerm_subnet_name  = "soumya-subnet"
  resource_group_name  = "soumya-rg"
  virtual_network_name = "soumya-vnet"
  address_prefixes     = ["10.0.1.0/24"]
  depends_on           = [module.azurerm_virtual_network,module.azurerm_resource_group]
}


module "azurerm_backend_subnet" {
  source               = "../module/azurerm_subnet"
  azurerm_subnet_name  = "soumya-subnet2"
  resource_group_name  = "soumya-rg"
  virtual_network_name = "soumya-vnet"
  address_prefixes     = ["10.0.2.0/24"]
  depends_on           = [module.azurerm_virtual_network,module.azurerm_resource_group]
}
module "azurerm_public_ip_frontend" {
  source              = "../module/azurerm_public_ip"
  public_ip_name      = "soumya-pip"
  resource_group_name = "soumya-rg"
  location    = "West Europe"
  depends_on          = [module.azurerm_virtual_network, module.azurerm_frontend_subnet, module.azurerm_resource_group]
}

module "azurerm_public_ip_backend" {
  source              = "../module/azurerm_public_ip"
  public_ip_name      = "soumya-pip-backend"
  resource_group_name = "soumya-rg"
  location            = "West Europe"
    depends_on          = [module.azurerm_virtual_network, module.azurerm_backend_subnet, module.azurerm_resource_group]
}
# module "azurerm_virtual_machine_frontend" {
#    depends_on             = [module.azurerm_frontend_subnet, module.azurerm_public_ip_frontend, module.azurerm_resource_group]
#   source                 = "../modules/azurerm_virtual_machine"
#   network_interface_name = "frontend_nic"
#   location               = "North Europe"
#   resource_group_name    = "soumya-rg"
#   ip_name                = "frontend_ip"
#   virtual_machine_name   = "todoFrontendVM"
#   subnet_name            = "frontend-subnets"
#   virtual_network_name   = "soumya_vnet"
#   public_ip_name         = "soumya_pip"
#   # secret_username_name   = "vm-username1"
#   # secret_password_name   = "vm-password1"
#   admin_username         = "adminuser"
#   admin_password         = "Cricket@12342024"
#   image_publisher        = "Canonical"
#   image_offer            = "ubuntu-24_04-lts"
#   image_sku              = "ubuntu-pro-gen1"
#   image_version          = "latest"
#   # key_vault_name         = "bhaweshKV"
# }


#

module "azurerm_virtual_machine_frontend" {
  depends_on = [
    module.azurerm_frontend_subnet,
    module.azurerm_public_ip_frontend,
    module.azurerm_resource_group,
    
    
  ]
  source = "../module/azurerm_virtual_machine"

  # VM resource group and location
  resource_group_name  = "soumya-rg"
  location             = "West Europe"
  virtual_machine_name = "todoFrontendVM"

  # NIC resource group and name
  network_interface = "frontend-nic"
  network_interface_id = "frontend-nic-id" # Replace with actual NIC resource ID or reference
  # Subnet resource group, vnet, and subnet
  subnet_name          = "soumya-subnet"
  virtual_network_name = "soumya-vnet"

  # Public IP resource group and name
  public_ip_name = "soumya-pip"

  # VM image and credentials
  admin_username  = "adminuser"
  admin_password  = "Cricket@12342024"
  image_publisher = "Canonical"
  image_offer     = "ubuntu-24_04-lts"
  image_sku       = "ubuntu-pro-gen1"
  image_version   = "latest"
}

# module "azurerm_virtual_machine_backend" {
#    depends_on             = [  module.azurerm_backend_subnet, module.azurerm_public_ip_backend, module.azurerm_resource_group]
#   source                 = "../modules/azurerm_virtual_machine"
#   network_interface_name = "backend_nic"
#   location               = "North Europe"
#   resource_group_name    = "soumya-rg"
#   ip_name                = "backend_ip"
#   virtual_machine_name   = "todoBackendVM"
#   subnet_name            = "backend-subnets"
#   virtual_network_name   = "soumya_vnet"
#   public_ip_name         = "soumya_pip_backend"
#   # secret_username_name   = "vm-username2"
#   # secret_password_name   = "vm-password2"
#   admin_username         = "adminuser"
#   admin_password         = "Cricket@12342024"
#   image_publisher        = "Canonical"
#   image_offer            = "ubuntu-24_04-lts"
#   image_sku              = "ubuntu-pro-gen1"
#   image_version          = "latest"
#   # key_vault_name         = "bhaweshKV"
# }

# module "azurerm_virtual_machine_backend" {
#   depends_on = [
#     module.azurerm_backend_subnet,
#     module.azurerm_public_ip_backend,
#     module.azurerm_resource_group
#   ]
#   source = "../module/azurerm_virtual_machine"

#   resource_group_name  = "soumya-rg"
#   location             = "West Europe"
#   virtual_machine_name = "todoBackendVM"

#   subnet_name          = "soumya-subnet2"
#   virtual_network_name = "soumya-vnet"
#   public_ip_name       = "soumya-pip-backend"

#   admin_username  = "adminuser"
#   admin_password  = "Cricket@12342024"
#   image_publisher = "Canonical"
#   image_offer     = "ubuntu-24_04-lts"
#   image_sku       = "ubuntu-pro-gen1"
#   image_version   = "latest"
# }


module "azurerm_virtual_machine_backend" {
  depends_on = [
    module.azurerm_backend_subnet,
    module.azurerm_public_ip_backend,
    module.azurerm_resource_group,
    
    
  ]
  source = "../module/azurerm_virtual_machine"

  resource_group_name  = "soumya-rg"
  location             = "West Europe"
  virtual_machine_name = "todoBackendVM"

  subnet_name          = "soumya-subnet2"
  virtual_network_name = "soumya-vnet"
  public_ip_name       = "soumya-pip-backend"
  network_interface    = "backend-nic"
  network_interface_id = "backend-nic-id" # Replace with actual NIC resource ID or reference
  admin_username  = "adminuser"
  admin_password  = "Cricket@12342024"
  image_publisher = "Canonical"
  image_offer     = "ubuntu-24_04-lts"
  image_sku       = "ubuntu-pro-gen1"
  image_version   = "latest"
}