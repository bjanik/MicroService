variable "location" {
  description = "Name of the location"
  type        = string
}

variable "tenant_id" {
  description = "Id of the tenant"
  type        = string
}

variable "admin_key_vault_object_ids" {
  description = "Ids of objects with admin permissions on key vault"
  type        = list(string)
}