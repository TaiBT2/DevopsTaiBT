# variable for postgres
variable "project" {
  description = "The name of the project"
  type        = string
}
variable "location" {
  description = "The location of the resources"
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  
}
variable "sku_name" {
  type = string
}
variable "storage_mb" {
  type = number
}
variable "administrator_login" {
  type = string
}
variable "administrator_login_password" {
  type = string
  
}
variable "version" {
  type = string
}