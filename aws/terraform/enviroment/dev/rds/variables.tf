# variables for module rds
variable "aws_region" {
  description = "value of the region"
  type = string
}
 variable "rds_username" {
   description = "Username for the master DB user"
   type        = string
 }
 variable "rds_port" {
   description = "The port on which the DB accepts connections"
   type        = number
   
 }
 variable "rds_availability_zone" {
   description = "The AZ for the RDS instance"
   type        = string
   
 }
 variable "rds_engine_version" {
   description = "The version number of the database engine to be used for the RDS instance"
   type        = string
   
 }
 variable "rds_instance_class" {
   description = "The instance type of the RDS instance"
   type        = string
   
 }
 variable "rds_instance_identifier" {
   description = "The name of the RDS instance"
   type        = string
   
 }
 variable "rds_engine" {
   description = "The name of the database engine to be used for the RDS instance"
   type        = string
   
 }
 variable "rds_allocated_storage" {
   description = "The allocated storage in gibibytes"
   type        = number
   
 }
 variable "rds_password" {
   description = "Password for the master DB user"
   type        = string
   
 }
 variable "db_subnet_group_name" {
   description = "The name of the DB subnet group"
   type        = string
   
 }
 variable "rds_multi_az" {
   description = "Specifies if the RDS instance is multi-AZ"
   type        = bool
   
 }
 variable "rds_storage_type" {
   description = "One of standard (magnetic), gp2 (general purpose SSD), or io1 (provisioned IOPS SSD)"
   type        = string
   
 }
 variable "rds_storage_encrypted" {
   description = "Specifies whether the DB instance is encrypted"
   type        = bool
   
 }