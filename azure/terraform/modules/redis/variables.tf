# value redis
# Path: azure/terraform/modules/redis/variables.tf
variable "project" {
  description = "The name of the project"
  type        = string
  
}
variable "location" {
  description = "The location of the resources"
  type        = string
  
}
variable "quantity" {
  description = "The quantity of redis instances"
  type        = number
  default     = 1
  
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  
}
variable "capacity" {
  description = "The capacity of the redis instance"
  type        = number
  default     = 1
  
}
variable "family" {
  description = "The family of the redis instance"
  type        = list(string)
  default     = [
    "C",
    "P"
  ]
  
}
variable "sku_name" {
  description = "The sku name of the redis instance"
  type        = string
  default     = "Basic"
  
}
variable "enable_non_ssl_port" {
  description = "Enable non ssl port"
  type        = bool
  default     = false
  
}

variable "public_network_access_enabled" {
  description = "Enable public network access"
  type        = bool
  default     = false
  
} 
variable "private_static_ip_address" {
  description = "The private static ip address"
  type        = string
  default     = null
  
}