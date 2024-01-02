project = "Synodus"
location = "southeastasia"
resource_group_name = "SynodusRG"
address_space = [ "10.0.0.0/16" ]
address_prefix_public = "10.0.2.0/24"
address_prefix_private = "10.0.1.0/24"
tags = {
  "Env" = "Dev",
  "Project" = "Synodus"
}
security_rules_public = [ {
    name                     = "Allow-SSH-Internet"
    priority                 = 100
    direction                = "Inbound"
    access                   = "Allow"
    protocol                 = "Tcp"
    source_port_range        = "*"
    destination_port_range   = "22"
    source_address_prefix    = "*"
    destination_address_prefix = "*"
},
{
    name                     = "Allow-HTTP-Internet"
    priority                 = 101
    direction                = "Inbound"
    access                   = "Allow"
    protocol                 = "Tcp"
    source_port_range        = "*"
    destination_port_range   = "80"
    source_address_prefix    = "*"
    destination_address_prefix = "*"
},
{
    name                     = "Allow-HTTPS-Internet"
    priority                 = 102
    direction                = "Inbound"
    access                   = "Allow"
    protocol                 = "Tcp"
    source_port_range        = "*"
    destination_port_range   = "443"
    source_address_prefix    = "*"
    destination_address_prefix = "*"
} ]

security_rules_private = [ {
    name                     = "Allow-SSH-Private"
    priority                 = 100
    direction                = "Inbound"
    access                   = "Allow"
    protocol                 = "Tcp"
    source_port_range        = "*"
    destination_port_range   = "22"
    source_address_prefix    = "*"
},
{
    name                     = "Allow-HTTP-Private"
    priority                 = 101
    direction                = "Inbound"
    access                   = "Allow"
    protocol                 = "Tcp"
    source_port_range        = "*"
    destination_port_range   = "80"
    source_address_prefix    = "*"
    destination_address_prefix = "*"
},
{
    name                     = "Allow-HTTPS-Private"
    priority                 = 102
    direction                = "Inbound"
    access                   = "Allow"
    protocol                 = "Tcp"
    source_port_range        = "*"
    destination_port_range   = "443"
    source_address_prefix    = "*"
    destination_address_prefix = "*"
}
]
security_rules_paas = [ {
    name                     = "Allow-SSH-PaaS"
    priority                 = 100
    direction                = "Inbound"
    access                   = "Allow"
    protocol                 = "Tcp"
    source_port_range        = "*"
    destination_port_range   = "22"
    source_address_prefix    = "*"
},
{
    name                     = "Allow-HTTP-PaaS"
    priority                 = 101
    direction                = "Inbound"
    access                   = "Allow"
    protocol                 = "Tcp"
    source_port_range        = "*"
    destination_port_range   = "80"
    source_address_prefix    = "*"
    destination_address_prefix = "*"
},
{
    name                     = "Allow-HTTPS-PaaS"
    priority                 = 102
    direction                = "Inbound"
    access                   = "Allow"
    protocol                 = "Tcp"
    source_port_range        = "*"
    destination_port_range   = "443"
    source_address_prefix    = "*"
    destination_address_prefix = "*"
}
]
# aks
node_count = 1
enable_auto_scaling = true
min_count = 1
max_count = 3
vm_size = "Standard_D2s_v3"
vnet_integration_enabled =true
enable_node_public_ip = false
zones = [ "zone1","zone2" ]
# node pool
node_pool_name = "nodepool1"
node_pool_node_count = 1
node_pool_vm_size = "Standard_D2s_v3"
node_pool_enable_auto_scaling = true
node_pool_min_count = 1
node_pool_max_count = 3
node_pool_enable_node_public_ip = false
node_pool_os_sku = "Ubuntu"
node_pool_scale_down_mode = "Delete"
node_pool_tags = {
  "Env" = "Dev",
  "Project" = "Synodus"
}

