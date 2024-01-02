terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  region = var.aws_region
}
module "rds" {
    source = "../../../module/rds"
    rds_username = var.rds_username
    rds_port = var.rds_port
    db_subnet_group_name = var.db_subnet_group_name
    rds_availability_zone = var.rds_availability_zone
    rds_engine_version = var.rds_engine_version
    rds_instance_class = var.rds_instance_class
    rds_instance_identifier = var.rds_instance_identifier
    rds_engine = var.rds_engine
    rds_allocated_storage = var.rds_allocated_storage
    rds_password = var.rds_password
    rds_multi_az = var.rds_multi_az
    rds_storage_type = var.rds_storage_type
    rds_storage_encrypted = var.rds_storage_encrypted
}