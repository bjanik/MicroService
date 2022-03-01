resource "azurerm_servicebus_namespace" "sbn" {
  name                = local.resources_name.sbn
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku = "Basic"
}

resource "azurerm_servicebus_queue" "sbq" {
  name         = local.resources_name.queue
  namespace_id = azurerm_servicebus_namespace.sbn.id
}