variable "resource_group_location" {
  type        = string
  default     = "westeurope"
  #   default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  type        = string
#   default     = "mysql-fs-db-rg"
  default = "surge-devops"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}