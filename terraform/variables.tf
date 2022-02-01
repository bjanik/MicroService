# variable "resource_group_name" {
#   description = "Name of the resource group"
#   type        = string
# }

# variable "service_bus_namespace_name" {
#   description = "Name of the service bus"
#   type        = string
# }

# variable "service_bus_queue_name" {
#   description = "Name of the service bus queue"
#   type        = string
# }

variable "location" {
  description = "Name of the location"
  type        = string
}

variable "tenant_id" {
  description = "Id of the tenant"
  type        = string
}