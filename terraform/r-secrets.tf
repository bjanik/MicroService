resource "azurerm_key_vault_secret" "kvsecrets" {
  for_each = local.secrets_mapping

  name         = each.key
  value        = each.value
  key_vault_id = azurerm_key_vault.kv.id
}