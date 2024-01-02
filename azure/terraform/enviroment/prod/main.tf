provider "azurerm" {
  features {}
}

module "nvet" {
  source = "./modules/nvet"
  project = var.project
  resource_group_name = var.resource_group_name
  address_space = var.address_space
  address_prefix_public = var.address_prefix_public
  address_prefix_private = var.address_prefix_private
  location = var.location
  tags = var.tags
  security_rules_public = var.security_rules_public
  security_rules_private = var.security_rules_private
  security_rules_paas = var.security_rules_paas
}

module "aks" {
  source = "./modules/aks"
  project = var.project
  resource_group_name = var.resource_group_name
  location = var.location
  tags = var.tags
  node_count = var.node_count
  enable_auto_scaling = var.enable_auto_scaling
  max_count = var.max_count
  min_count = var.min_count
  vm_size = var.vm_size
  vnet_integration_enabled = var.vnet_integration_enabled
  enable_node_public_ip = var.enable_node_public_ip
  zones = var.zones
  # node_pool
  node_pool_name = var.node_pool_name
  node_pool_vm_size = var.node_pool_vm_size
  node_pool_node_count = var.node_pool_node_count
  node_pool_os_disk_size_gb = var.node_pool_os_disk_size_gb
  node_pool_os_type = var.node_pool_os_type
  node_pool_tags = var.node_pool_tags
  node_pool_enable_auto_scaling = var.node_pool_enable_auto_scaling
  node_pool_max_count = var.node_pool_max_count
  node_pool_min_count = var.node_pool_min_count
  node_pool_enable_node_public_ip = var.node_pool_enable_node_public_ip
  node_pool_os_sku = var.node_pool_os_sku
  node_pool_scale_down_mode = var.node_pool_scale_down_mode

  depends_on = [module.nvet]
}