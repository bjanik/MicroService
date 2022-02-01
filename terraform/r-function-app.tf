resource "azurerm_function_app" "funapp" {
  name                = local.resources_name.fun
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  app_service_plan_id = azurerm_app_service_plan.asp.id

  storage_account_name       = azurerm_storage_account.sa.name
  storage_account_access_key = azurerm_storage_account.sa.primary_access_key

  identity {
    type = "SystemAssigned"
  }

  os_type = "linux"

  site_config {
    always_on        = true
    linux_fx_version = "NODE|14LTS" # https://github.com/Azure/app-service-linux-docs/tree/master/Runtime_Support
  }

  app_settings = {
    "FUNCTIONS_EXTENSION_VERSION"  = "~3" 
    "FUNCTIONS_WORKER_RUNTIME"     = "node"
    "REDIS_CONNECTION_STRING"      = "@Microsoft.KeyVault(VaultName=${azurerm_key_vault.kv.name};SecretName=${azurerm_key_vault_secret.kvsecrets["redisconnstring"].name})"
    "SERVICEBUS_CONNECTION_STRING" = "@Microsoft.KeyVault(VaultName=${azurerm_key_vault.kv.name};SecretName=${azurerm_key_vault_secret.kvsecrets["queueconnstring"].name})"
  }
}