resource "azurerm_servicebus_namespace" "sbn" {
  name                = local.resources_name.sbn
  location            = var.location
  resource_group_name = local.rg_name

  sku = "Basic"
}

resource "azurerm_servicebus_queue" "sbq" {
  name         = local.resources_name.queue
  namespace_id = azurerm_servicebus_namespace.sbn.id
}