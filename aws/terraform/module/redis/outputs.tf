output "redis_endpoint" {
  description = "The connection endpoint for the Redis instance"
  value       = aws_elasticache_cluster.example.cache_nodes.0.address
}

output "redis_port" {
  description = "The port for the Redis instance"
  value       = aws_elasticache_cluster.example.cache_nodes.0.port
}