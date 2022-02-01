resource "azurerm_key_vault" "kv" {
  name                = local.resources_name.kv
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tenant_id           = var.tenant_id

  purge_protection_enabled = false
  sku_name                 = "standard"

}

resource "azurerm_key_vault_access_policy" "kvpolicies" {
  for_each = toset(var.admin_key_vault_object_ids)

  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = var.tenant_id
  object_id    = each.value

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete"
  ]
}

resource "azurerm_key_vault_access_policy" "fun_policy" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = var.tenant_id
  object_id    = azurerm_function_app.funapp.identity[0].principal_id

  secret_permissions = [
    "Get",
    "List"
  ]
}