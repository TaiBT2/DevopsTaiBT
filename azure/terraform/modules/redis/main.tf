resource "azurerm_redis_cache" "redis" {
    name                = "${var.project}-redis"
    location            = var.location
    resource_group_name = var.resource_group_name
    capacity            = var.capacity
    family              = values(var.family)[0]
    enable_non_ssl_port = var.enable_non_ssl_port
    sku_name            = var.sku_name
    
    public_network_access_enabled   = var.public_network_access_enabled
    private_static_ip_address = var.private_static_ip_address
}

