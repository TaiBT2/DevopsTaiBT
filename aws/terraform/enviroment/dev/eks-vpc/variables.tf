variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-west-2"
}

variable "aws_availability_zones" {
  description = "AWS availability zones to launch servers."
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  
}
variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The environment where the VPC will be created"
  type        = string
  default     = "dev"
  
}
variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = [""]
  
}
variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = [""]
  
}
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = ""
  
}


variable "node_instance_type" {
  description = "The instance type to use for the nodes"
  type        = string
  default     = "t3.medium"
  
}
variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "eks-cluster"
  
}
variable "cluster_version" {
  description = "The Kubernetes version to use for the EKS cluster"
  type        = string
  default     = "1.20"
  
}
variable "node_group_name" {
  description = "The name of the node group"
  type        = string
  
}
variable "desired_capacity" {
  description = "The desired number of nodes"
  type        = number
  default     = 3
  
}
variable "min_size" {
  description = "The minimum number of nodes"
  type        = number
  default     = 1
  
}
variable "max_size" {
  description = "The maximum number of nodes"
  type        = number
  default     = 3
  
}
variable "endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled. Default is false"
  type        = bool
  default     = false
  
}
variable "endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled. Default is true"
  type        = bool
  default     = true
  
}
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
  
}
# variable "vpc_id" {}
