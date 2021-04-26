
# terraform-azure-functions
The purpose of this repo is to provide a base terraform modules for deploying azure resource group. 

## Example Invocation:
Calling function:

```terraform
provider "azurerm" {
    version = ">=2.45.1"
    features {}
}

#====================================================================================
locals {
    tags = {
        environment     = "DEV"
        owner           = "jp"
    }
    rgs = {
        rg1 = {
            name = "RG-Name1"
            location = "East US2"
        } 
        rg2 = { 
            name = "RG-Name2"
            location = "west US"
        } 
        rg3 = { 
            name = "RG-Name3"
            location = "Central US"
        } 
    }
}

#====================================================================================
module "rg_test" {
  source  = "github.com/ploegert/terraform-azurerm-rg"

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
```