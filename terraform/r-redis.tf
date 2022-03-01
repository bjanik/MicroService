resource "azurerm_redis_cache" "rc" {
  name                = local.resources_name.redis
  resource_group_name = local.rg_name
  location            = var.location

  capacity = 0
  family   = "C"
  sku_name = "Basic"
}