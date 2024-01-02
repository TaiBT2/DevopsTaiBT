# variable for the virtual network
variable "project" {
  description = "The name of the project"
  type        = string
}
variable "location" {
  description = "The location of the resources"
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}
variable "address_prefix_public" {
  description = "The address prefix for the public subnet"
  type        = string
}
variable "address_prefix_private" {
  description = "The address prefix for the private subnet"
  type        = string
}
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
variable "security_rules_public" {
  description = "A map of tags to add to all resources"
  type        = list(object({
    name                     = string
    priority                 = number
    direction                = string
    access                   = string
    protocol                 = string
    source_port_range        = string
    destination_port_range   = string
    source_address_prefix    = string
    destination_address_prefix = string
  }))
  default = []
  
}
variable "security_rules_private" {
  description = "A map of tags to add to all resources"
  type        = list(object({
    name                     = string
    priority                 = number
    direction                = string
    access                   = string
    protocol                 = string
    source_port_range        = string
    destination_port_range   = string
    source_address_prefix    = string
    destination_address_prefix = string
  }))
  default = []
}
variable "security_rules_paas" {
  description = "A map of tags to add to all resources"
  type        = list(object({
    name                     = string
    priority                 = number
    direction                = string
    access                   = string
    protocol                 = string
    source_port_range        = string
    destination_port_range   = string
    source_address_prefix    = string
    destination_address_prefix = string
  }))
  default = []
}
# variable aks
variable "node_count" {
  description = "The number of nodes in the Kubernetes node pool"
  type        = number
  default     = 1
}
variable "enable_auto_scaling" {
  description = "Whether to enable auto scaling"
  type        = bool
  default     = true
}
variable "max_count" {
  description = "The maximum number of nodes in the Kubernetes node pool"
  type        = number
  default     = 3
}
variable "min_count" {
  description = "The minimum number of nodes in the Kubernetes node pool"
  type        = number
  default     = 1
}
variable "vm_size" {
  description = "The size of each virtual machine in the Kubernetes node pool"
  type        = string
  default     = "Standard_D2s_v3"
}
variable "vnet_integration_enabled" {
  description = "Whether to enable VNET integration"
  type        = bool
  default     = true
}
variable "enable_node_public_ip" {
  description = "Whether to enable public IP on the Kubernetes node pool"
  type        = bool
  default     = false
}
variable "zones" {
  description = "The availability zones in which the Kubernetes node pool will be created"
  type        = list(string)
  default     = []
}
# variable node pool
variable "node_pool_name" {
  description = "The name of the node pool"
  type        = string
  default     = "default"
}
variable "node_pool_vm_size" {
  description = "The size of each virtual machine in the Kubernetes node pool"
  type        = string
  default     = "Standard_D2s_v3"
}
variable "node_pool_node_count" {
  description = "The number of nodes in the Kubernetes node pool"
  type        = number
  default     = 1
}
variable "node_pool_os_disk_size_gb" {
  description = "The disk size of each virtual machine in the Kubernetes node pool"
  type        = number
  default     = 30
}

variable "node_pool_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
variable "node_pool_enable_auto_scaling" {
  description = "Whether to enable auto scaling"
  type        = bool
  default     = true
}
variable "node_pool_max_count" {
  description = "The maximum number of nodes in the Kubernetes node pool"
  type        = number
  default     = 3
}
variable "node_pool_min_count" {
  description = "The minimum number of nodes in the Kubernetes node pool"
  type        = number
  default     = 1
}
variable "node_pool_enable_node_public_ip" {
  description = "Whether to enable public IP on the Kubernetes node pool"
  type        = bool
  default     = false
}
variable "node_pool_os_sku" {
  description = "The SKU of the operating system"
  type        = string
  default     = "Ubuntu"
}
variable "node_pool_scale_down_mode" {
  description = "The scale down mode of the Kubernetes node pool"
  type        = string
  default     = "Delete"
}