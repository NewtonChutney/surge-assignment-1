output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

# output "azurerm_mysql_flexible_server" {
#   value = azurerm_mysql_flexible_server.default.name
# }

# output "admin_login" {
#   value = azurerm_mysql_flexible_server.default.administrator_login
# }

# output "admin_password" {
#   sensitive = true
#   value     = azurerm_mysql_flexible_server.default.administrator_password
# }

# output "mysql_flexible_server_database_name" {
#   value = azurerm_mysql_flexible_database.default.name
# }

# output "kube_config" {
#   value = azurerm_kubernetes_cluster.aks.kube_config_raw
#   sensitive = true
# }
