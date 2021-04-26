
# ==================================================
# Terraform & Providers
# ==================================================
terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.56.0"
    }
  }
}

provider "azurerm" {
  features {}
}


# ==================================================
# Variables 
# ==================================================
variable "resource_groups" { default = {} }
variable tags {
  type        = map
  description = "Collection of the tags referenced by the Azure deployment"
  default = {
    source      = "terraform"
    environment = "dev"
    costCenter  = ""
  }
}


# ==================================================
# Resources
# ==================================================
resource "azurerm_resource_group" "rg" {
  for_each      = var.resource_groups
  
  name          = each.value.name
  location      = each.value.location
  tags          = var.tags
}



# ==================================================
# Output
# ==================================================
output "rg_names" {
  #value = var.resource_group
  value       = flatten(concat([for s in azurerm_resource_group.rg : s.name]))
}
output "rg_ids" {
#  value = azurerm_resource_group.common_rg.id
  value       = flatten(concat([for s in azurerm_resource_group.rg : s.id]))
}
