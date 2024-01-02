aws_region = "us-east-1"
aws_availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
node_instance_type = "t3.medium"
vpc_cidr = "10.1.0.0/16"
vpc_name = "vpcdemo"
environment = "dev"
public_subnets = [ "10.1.1.0/24", "10.1.2.0/24" ]
private_subnets = [  "10.1.3.0/24", "10.1.4.0/24"]
cluster_name = "demo-cluster"
cluster_version = "1.27"
node_group_name = "nodegroup"
desired_capacity = 2
max_size = 3
min_size = 1
endpoint_private_access = false
endpoint_public_access = true
project_name = "Cleo"
tags = {
  "Env" = "Dev"
}
