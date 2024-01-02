data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}


resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  sku_tier                            = var.sku_tier

  default_node_pool {
    name       = var.node_pool_name
    node_count = var.node_count
    enable_auto_scaling = var.enable_auto_scaling
    max_count = var.max_count
    min_count = var.min_count
    vm_size    = var.vm_size
    vnet_subnet_id = data.azurerm_subnet.subnet.id
    os_sku    = var.os_sku
    scale_down_mode  = var.scale_down_mode
    enable_node_public_ip = var.enable_node_public_ip
    zones = var.zones
    kubelet_config {
      cpu_manager_policy = "static"
    }
    tags = var.tags
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "node_pool" {
  name                = var.node_pool_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size              = var.node_pool_vm_size
  node_count           = var.node_pool_node_count
  os_disk_size_gb      = var.node_pool_os_disk_size_gb
  vnet_subnet_id       = data.azurerm_subnet.subnet.id
  zones = var.zones
  enable_auto_scaling = var.node_pool_enable_auto_scaling
  max_count = var.node_pool_max_count
  min_count = var.node_pool_min_count
  enable_node_public_ip = var.node_pool_enable_node_public_ip
  os_sku = var.node_pool_os_sku
  tags = var.node_pool_tags
}
