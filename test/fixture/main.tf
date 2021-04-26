
provider "azurerm" {
  features {}
}


module "rg" {
  source                        = "../.."
  location                      = "East US2"
  naming_prefix                 = "appczone"
  naming_suffix                 = "test"
}