resource "azurerm_resource_group" "rg" {
  name     = local.resources_name.rg
  location = var.location
}