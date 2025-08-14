module "azurerm_resource_group" {
  source              = "../module/azurerm_resource_group"
  resource_group_name = "soumya1-rg"
  location            = "East Asia"
}

module "azurerm_virtual_network" {
  source                       = "../module/azurerm_virtual_network"
  azurerm_virtual_network_name = "soumya_vnet"
  location                     = "East Asia"
  resource_group_name          = "soumya1-rg"
  address_space                = ["10.0.0.0/16"]
  depends_on                   = [module.azurerm_resource_group]
}

module "azurerm_frontend_subnet" {
  source               = "../module/azurerm_subnet"
  azurerm_subnet_name  = "soumya-fsubnet"
  resource_group_name  = "soumya1-rg"
  virtual_network_name = "soumya_vnet"
  address_prefixes     = ["10.0.1.0/24"]
  depends_on           = [module.azurerm_virtual_network,module.azurerm_resource_group]
}


module "azurerm_backend_subnet" {
  source               = "../module/azurerm_subnet"
  azurerm_subnet_name  = "soumya-bsubnet"
  resource_group_name  = "soumya1-rg"
  virtual_network_name = "soumya_vnet"
  address_prefixes     = ["10.0.2.0/24"]
  depends_on           = [module.azurerm_virtual_network,module.azurerm_resource_group]
}
module "frontend_public_ip" {
  source              = "../module/azurerm_public_ip"
  public_ip_name      = "soumya_pip"
  resource_group_name = "soumya1-rg"
  location    = "East Asia"
  depends_on          = [module.azurerm_virtual_network]
}

module "backend_public_ip" {
  source              = "../module/azurerm_public_ip"
  public_ip_name      = "soumya-pip-backend"
  resource_group_name = "soumya1-rg"
  location            = "East Asia"
    depends_on          = [module.azurerm_virtual_network]
}
module "azurerm_virtual_machine_frontend" {
  depends_on = [module.azurerm_frontend_subnet,module.frontend_public_ip,module.azurerm_virtual_network,module.azurerm_resource_group]
  source                   = "../module/azurerm_virtual_machine"
  virtual_machine_name     = "todoFrontendVM"
  location                 = "East Asia"
  resource_group_name      = "soumya1-rg"
  subnet_name              = "soumya-fsubnet"
  virtual_network_name     = "soumya_vnet"
  public_ip_name           = "soumya_pip"         
  network_interface_name   = "frontend-nic"
  ip_configuration_name    = "frontend_ip"
  admin_username           = "adminuser"
  admin_password           = "Cricket@12342024"
  image_publisher          = "Canonical"
  image_offer              = "ubuntu-24_04-lts"
  image_sku                = "ubuntu-pro-gen1"
  image_version            = "latest"


}


module "azurerm_virtual_machine_backend" {
  depends_on               = [module.azurerm_backend_subnet,module.backend_public_ip,module.azurerm_virtual_network,module.azurerm_resource_group]
  source                   = "../module/azurerm_virtual_machine"
  virtual_machine_name     = "todobackedndVM"
  location                 = "East Asia"
  resource_group_name      = "soumya1-rg"
  subnet_name              = "soumya-bsubnet"
  virtual_network_name     = "soumya_vnet"
  public_ip_name           = "soumya-pip-backend"
  network_interface_name   = "backend-nic"
  ip_configuration_name    = "internal"
  admin_username           = "adminuser"
  admin_password           = "Cricket@12342024"
  image_publisher          = "Canonical"
  image_offer              = "0001-com-ubuntu-server-focal"
  image_sku                = "20_04-lts"
  image_version            = "latest"

}

module "azurerm_sql_server" {
  source                   = "../module/azurerm_sql_server"
  mssql_server_name        = "soumya-sql-server"
  resource_group_name      = "soumya1-rg"
  resource_group_location  = "East Asia"
  admin_username           = "sqladmin"
  admin_password           = "SoumyaAdmin@1234"
  depends_on               = [module.azurerm_resource_group]
}
module "sql_database" {
  depends_on          = [module.azurerm_sql_server]
  source              = "../module/azurerm_sql_database"
  sql_database_name       = "soumyadb"
  sql_server_name     = "soumya-sql-server"
  resource_group_name = "soumya1-rg"

}