provider "azurerm" {
    version = ">=2.45.1"
    features {}
}

#====================================================================================
locals {

    # internal Naming Tag : <ProductName><Env><Zone>-<Component/servicename>-<ResourceType>
    # cust Naming Tag  : <ResourceType>-<ProductName>-<Component/servicename>-<Environment>-<Project>-###

    tags = {
        environment     = "DEV"
        owner           = "jp"
    }

    rgs = {
        rg1 = {
            name = module.name1.resource_group.name
            location = "East US2"
        } 
        rg2 = { 
            name = module.name2.resource_group.name
            location = "west US"
        } 
        rg3 = { 
            name = module.name3.resource_group.name
            location = "Central US"
        } 
    }

}

#====================================================================================

module "name1" {
  source  = "github.com/ploegert/terraform-azurerm-naming"
  prefix = [ "obtzz1", "hyperion"]
  suffix = [ ]
}

module "name2" {
  source  = "github.com/ploegert/terraform-azurerm-naming"
  prefix = [ "obtzz2", "core"]
  suffix = [ ]
}

module "name3" {
  source  = "github.com/ploegert/terraform-azurerm-naming"
  prefix = [ ]
  suffix = [ "obt", "core", "stg", "unistad"]
}

module "rg_test" {
    source = "../"

    resource_groups = local.rgs
    tags            = local.tags
}

#====================================================================================
output "names" {
    description = "Returns a map of resource_group key -> resource_group name"

    value = module.rg_test.rg_names
}

output "ids" {
    description = "Returns a map of resource_group key -> resource_group id"

    value = module.rg_test.rg_ids
}
