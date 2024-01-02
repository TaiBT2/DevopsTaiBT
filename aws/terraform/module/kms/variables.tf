variable "description" {
  type = "string"
  description = "The description of the key"
  
}
variable "deletion_window_in_days" {
  type = "number"
  description = "Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days"
  default = 30
  
}
variable "tags" {
  type = "map"
  description = "A mapping of tags to assign to the resource"
  default = {}
  
}
variable "enable_key_rotation" {
  type = "bool"
  description = "Specifies whether key rotation is enabled"
  default = false
  
}
variable "is_enabled" {
  type = "bool"
  description = "Specifies whether the key is enabled"
  default = true
  
}