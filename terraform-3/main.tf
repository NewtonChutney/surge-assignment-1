provider "azurerm" {
  features {}
}

# Generate random resource group name
resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

# Generate random value for the name
resource "random_string" "name" {
  length  = 8
  lower   = true
  numeric = false
  special = false
  upper   = false
}

# resource "azurerm_resource_group" "example" {
#   name     = "surge-devops"
# #   location = "East US"
#   location = "West US"
# }
resource "azurerm_resource_group" "rg" {
  name     = random_pet.rg_name.id
  location = var.resource_group_location
}