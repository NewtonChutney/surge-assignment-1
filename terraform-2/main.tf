provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "surge-devops"
#   location = "East US"
  location = "West US"
}

resource "azurerm_mysql_flexible_server" "example" {
  name                    = "nkm-mysql-server"
  resource_group_name     = azurerm_resource_group.example.name
  location                = azurerm_resource_group.example.location
  version                 = "8.0.21"
#   sku_name                = "Standard_D2s_v3"
  sku_name                = "B_Standard_B1s"
#   storage_mb             = 5120
  administrator_login    = "mysqladmin"
  administrator_password = "YourStrongPassword123!"  # Securely store passwords

  tags = {
    environment = "dev"
  }
}

resource "azurerm_mysql_flexible_server_firewall_rule" "example" {
  name                = "allow-public-internet"
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_mysql_flexible_server.example.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

resource "azurerm_mysql_flexible_database" "example" {
  name                = "example_database"
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_mysql_flexible_server.example.name
  collation = "utf8_unicode_ci"
  charset = "utf8"
}
