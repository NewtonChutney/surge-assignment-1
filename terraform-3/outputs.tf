output "rg_name" {
  sensitive = true
  value     = azurerm_resource_group.rg.name
}
# how do we get a terraform output variable and use it to deploy a containerized
# app in aks in github actions