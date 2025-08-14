terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.34.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "soumyarg"
    storage_account_name  = "backednsoumyastg"
    container_name        = "soumyatfstate"
    key                   = "terraform.tfstate"
  }
}




provider "azurerm" {
  features {}
  subscription_id = "9f199aee-1ad7-464f-bd74-4b88ef990086"
} 