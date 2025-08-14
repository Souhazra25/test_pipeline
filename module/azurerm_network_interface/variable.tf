variable "azurerm_virtual_network_name" {
  description = "The name of the Azure Virtual Network."
  type        = string          
  
}
variable "location" {
  description = "The location where the resources will be created."
  type        = string
}
variable "network_interface_name" {
  description = "The name of the network interface."
  type        = string
}
variable "ip_configuration_name" {
  description = "The name of the IP configuration."
  type        = string
}
variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
}
variable "public_ip_name" {
  description = "The name of the public IP."
  type        = string
}   
variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}
variable "address_space" {
  description = "The address space for the virtual network."
  type        = list(string)
}
variable "virtual_network_name" {
  description = "The name of the Azure Virtual Network."
  type        = string
}
variable "public_ip_address_id" {
  description = "The ID of the public IP address."
  type        = string
  
}