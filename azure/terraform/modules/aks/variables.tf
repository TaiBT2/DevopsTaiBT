variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "aks_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix specified when creating the managed cluster"
  type        = string
}

variable "sku_tier" {
  description = "The SKU tier for the managed cluster"
  type        = string
  default     = "Free"
  
}
variable "scale_down_mode" {
  description = "Scale down mode for cluster autoscaler"
  type        = string
  default     = "Delete"
  
}
variable "os_sku" {
  description = "The SKU of the operating system used for each node in the node pool"
  type        = string
  default     = "Ubuntu"
  
}
variable "vnet_integration_enabled" {
  description = "Whether to enable VNET integration"
  type        = bool
  default     = true
  
}
variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

## Default Node Pool Variables
variable "node_pool_name" {
  description = "The name of the node pool"
  type        = string
  default     = "default"
}
variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}
variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string
}
variable "cluster_name" {
  description = "The name of the cluster"
  type        = string
  
}
variable "node_count" {
  description = "The number of nodes in the Kubernetes node pool"
  type        = number
  default     = 1
}
variable "enable_auto_scaling" {
  description = "Whether to enable auto scaling"
  type        = bool
  default     = false
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
  description = "Whether to enable public IP on nodes"
  type        = bool
  default     = false
}
variable "zones" {
  description = "The availability zones in which the AKS cluster will be created"
  type        = list(string)
  default     = []
}


## Node Pool Variables
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
  description = "The disk size in GB to provision for each of the node pool nodes"
  type        = number
  default     = 30
}
variable "node_pool_os_type" {
  description = "The operating system type of the node pool nodes"
  type        = string
  default     = "Linux"
}
variable "node_pool_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "node_pool_enable_auto_scaling" {
  description = "Whether to enable auto scaling"
  type        = bool
  default     = false
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
  description = "Whether to enable public IP on nodes"
  type        = bool
  default     = false
}
variable "node_pool_scale_down_mode" {
  description = "Scale down mode for cluster autoscaler"
  type        = string
  default     = "Delete"
}
variable "node_pool_os_sku" {
  description = "The SKU of the operating system used for each node in the node pool"
  type        = string
  default     = "Ubuntu"
}

