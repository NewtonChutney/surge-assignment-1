variable "resource_group_location" {
  type        = string
  # default     = "westus"
  default     = "westeurope"
  #   default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  type        = string
  default = "surge-devops"
  description = <<EOT
    Prefix of the resource group name that's combined with a random ID,\
     so name is unique in your Azure subscription.
  EOT
}
