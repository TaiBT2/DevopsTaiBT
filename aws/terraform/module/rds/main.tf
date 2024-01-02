locals {
  db_subnet_group_name = var.db_subnet_group_name
}
# Compare this snippet from aws/terraform/module/rds/main.tf:
resource "aws_db_instance" "example" {
  engine           = var.rds_engine
  engine_version   = var.rds_engine_version
  instance_class   = var.rds_instance_class
  allocated_storage = var.rds_allocated_storage
  storage_type     = var.rds_storage_type
  username         = var.rds_username
  password         = var.rds_password
  availability_zone = var.rds_availability_zone
  db_subnet_group_name        = local.db_subnet_group_name
  multi_az         = var.rds_multi_az
  port = var.rds_port
  identifier = var.rds_instance_identifier
  storage_encrypted = var.rds_storage_encrypted
  skip_final_snapshot = true

  tags = {
    Name = "example-rds"
  }
}
