resource "azurerm_app_service_plan" "asp" {
  name                = local.resources_name.asp
  resource_group_name = local.rg_name
  location            = var.location

  kind     = "Linux"
  reserved = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}