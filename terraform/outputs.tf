output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "mysql_flexible_server" {
  value = azurerm_mysql_flexible_server.default.name
}

output "mysql_flexible_server_hostname" {
  value = azurerm_mysql_flexible_server.default.fqdn
}

output "mysql_flexible_server_database_name" {
  value = azurerm_mysql_flexible_database.default.name
}

output "admin_login" {
  value = azurerm_mysql_flexible_server.default.administrator_login
}

output "admin_password" {
  sensitive = true
  value     = azurerm_mysql_flexible_server.default.administrator_password
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "kube_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "kube_cluster_rg" {
  value = azurerm_kubernetes_cluster.aks.resource_group_name
}
