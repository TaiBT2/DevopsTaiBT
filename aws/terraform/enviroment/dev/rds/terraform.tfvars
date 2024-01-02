#value rds
rds_allocated_storage = 20
rds_engine = "postgres"
rds_engine_version = "12"
rds_instance_class = "db.t2.micro"
rds_username = "postgres"
rds_password = "value123"
rds_port = 5432
rds_multi_az = false
rds_storage_type = "gp2"
rds_storage_encrypted = false
rds_availability_zone = "us-east-1c"
db_subnet_group_name = "rds-demo"
aws_region = "us-east-1"
rds_instance_identifier = "book-rds-instance"