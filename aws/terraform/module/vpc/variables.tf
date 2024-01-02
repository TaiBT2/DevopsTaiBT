variable "region" {
  description = "The region where the VPC will be created"
  type        = string
  default     = "us-west-2"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
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
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = ""
  
}

variable "availability_zones" {
  description = "A list of availability zones in the region"
  type        = list(string)
}

variable "aws_security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "eks-cluster-sg"
  
}
# variable "sg_ingress_rules" {
#   description = "A list of ingress rules to apply to the security group"
#   type        = list(object({
#     from_port   = number
#     to_port     = number
#     protocol    = string
#     cidr_blocks = list(string)
#     description = string
#   }))
#   default     = [
#     {
#       from_port   = 0
#       to_port     = 65535
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#       description = "Allow all inbound traffic"
#     }
#   ]
# }