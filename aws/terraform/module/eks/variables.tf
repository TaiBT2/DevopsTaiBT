variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
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

variable "node_instance_type" {
  description = "The instance type to use for the nodes"
  type        = string
  default     = "t3.medium"
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
  default     = 5
}

# variable "vpc_id" {
#   description = "The ID of the VPC where the EKS cluster will be deployed"
#   type        = string
# }

variable "subnet_ids" {
  description = "The IDs of the subnets where the EKS cluster will be deployed"
  type        = list(string)
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


# depends_on = [ module.vpc ]
# variable "vpc_depends_on" {
#   type    = any
#   default = []
# }