resource "aws_elasticache_cluster" "example" {
  cluster_id           = var.redis_cluster_id
  engine               = var.engine
  node_type            = var.redis_instance_type
  num_cache_nodes      = var.num_cache_nodes
  parameter_group_name = var.parameter_group_name
  engine_version       = var.redis_engine_version
  port                 = var.redis_port
}