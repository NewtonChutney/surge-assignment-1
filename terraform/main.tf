# Generate random resource group name
resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  name     = random_pet.rg_name.id
  location = var.resource_group_location
}

# Generate random value for the name
resource "random_string" "name" {
  length  = 8
  lower   = true
  numeric = false
  special = false
  upper   = false
}

# Generate random value for the login password
resource "random_password" "password" {
  length           = 8
  lower            = true
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  numeric          = true
  override_special = "_"
  special          = true
  upper            = true
}

resource "azurerm_mysql_flexible_server" "default" {

  administrator_login    = random_string.name.result
  administrator_password = random_password.password.result
  location               = azurerm_resource_group.rg.location
  name                   = "mysqlfs-${random_string.name.result}"
  resource_group_name    = azurerm_resource_group.rg.name
  # sku_name                = "B_Standard_B1s"
  sku_name = "GP_Standard_D2ds_v4"
  version  = "8.0.21"
  #   storage_mb             = 5120
  zone = "1"
  tags = {
    environment = "dev"
  }
}

resource "azurerm_mysql_flexible_server_firewall_rule" "default" {
  name                = "allow-public-internet"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.default.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

resource "azurerm_mysql_flexible_database" "default" {
  name                = "default_database"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.default.name
  collation           = "utf8mb3_unicode_ci"
  charset             = "utf8mb3"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${random_string.name.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aks-${random_string.name.result}"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
    upgrade_settings {
      drain_timeout_in_minutes      = 0
      max_surge                     = "10%"
      node_soak_duration_in_minutes = 0
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "dev"
  }
}
