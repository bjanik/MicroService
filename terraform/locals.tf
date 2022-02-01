locals {
  project_name         = "account-manager"
  storage_account_name = format("%s%s", "accountmanager", "sa")

  resource_list = ["asp", "rg", "fun", "kv", "redis", "queue", "sbn"]
  resources_name = {
    for r in local.resource_list :
    r => format("%s-%s", local.project_name, r)
  }

  secrets_mapping = {
    "queueconnstring" : azurerm_servicebus_namespace.sbn.default_primary_connection_string,
    "redisconnstring" : azurerm_redis_cache.rc.primary_connection_string,
  }
}