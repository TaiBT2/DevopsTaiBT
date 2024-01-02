variable "bucket_name" {
  type = "string"
  description = "The name of the bucket"
  
}
variable "bucket_acl" {
  type = "string"
  description = "The ACL of the bucket"
  default = "private"
}