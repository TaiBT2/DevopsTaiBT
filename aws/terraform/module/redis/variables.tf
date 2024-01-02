variable "redis_name" {
  description = "The name of the Redis instance"
  type        = string
}

variable "redis_instance_type" {
  description = "The instance type of the Redis cluster"
  type        = string
  default     = "cache.t2.micro"
}

variable "redis_engine_version" {
  description = "The engine version of the Redis cluster"
  type        = string
  default     = "5.0.6"
}

variable "redis_subnet_group_name" {
  description = "The name of the subnet group for the Redis cluster"
  type        = string
}

variable "redis_security_group_ids" {
  description = "The list of security group IDs for the Redis cluster"
  type        = list(string)
}

variable "redis_cluster_id" {
  description = "The ID of the Redis cluster"
  type        = string
  
}
variable "engine" {
  description = "The name of the cache engine to be used for the clusters in this replication group"
  type        = string
  default     = "redis"
  
}
variable "num_cache_nodes" {
  description = "The number of cache nodes that the replication group should have"
  type        = number
  default     = 1
  
}
variable "parameter_group_name" {
  description = "The name of the parameter group to associate with this replication group"
  type        = string
  default     = "default.redis5.0.cluster.on"
  
}
variable "redis_port" {
  description = "The port number on which each of the cache nodes will accept connections"
  type        = number
  default     = 6379
  
}