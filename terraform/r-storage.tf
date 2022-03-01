resource "azurerm_storage_account" "sa" {
  name                = local.storage_account_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  account_tier             = "Standard"
  account_replication_type = "LRS"
}