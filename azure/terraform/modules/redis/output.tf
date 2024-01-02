output "redis_cache_name" {
    value = azurerm_redis_cache.redis.name
}

output "redis_cache_hostname" {
    value = azurerm_redis_cache.redis.hostname
}

output "redis_cache_port" {
    value = azurerm_redis_cache.redis.port
}

output "redis_cache_ssl_port" {
    value = azurerm_redis_cache.redis.ssl_port
}

output "redis_cache_primary_access_key" {
    value = azurerm_redis_cache.redis.primary_access_key
}

output "redis_cache_secondary_access_key" {
    value = azurerm_redis_cache.redis.secondary_access_key
}
