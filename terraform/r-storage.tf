resource "azurerm_storage_account" "sa" {
  name                = local.storage_account_name
  resource_group_name = local.rg_name
  location            = var.location

  account_tier             = "Standard"
  account_replication_type = "LRS"
}