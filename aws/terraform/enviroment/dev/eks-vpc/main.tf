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

module "vpc" {
  source = "../../../module/vpc"

  vpc_name = var.vpc_name
  project_name = var.project_name
  environment = var.environment
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  vpc_cidr = var.vpc_cidr
  availability_zones = var.aws_availability_zones
}


module "eks" {
  source = "../../../module/eks"
  cluster_name = var.cluster_name
  cluster_version = var.cluster_version

  # vpc_id = module.vpc.vpc_id
  subnet_ids = [module.vpc.private_subnets, module.vpc.private_subnets_2]
  node_group_name = var.node_group_name
  node_instance_type = var.node_instance_type
  desired_capacity = var.desired_capacity
  min_size = var.min_size
  max_size = var.max_size
  endpoint_private_access = var.endpoint_private_access
  endpoint_public_access = var.endpoint_public_access
  tags = var.tags
  
  depends_on = [ module.vpc ]
}
