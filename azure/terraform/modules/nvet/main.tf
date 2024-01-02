
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project}-vnet"
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  location            = "eastus"  # Add the "location" attribute

  subnet {
    name           = "${var.project}-subnet-public"
    address_prefix = var.address_prefix_public
    security_group = azurerm_network_security_group.sg-public.id
  }

  subnet {
    name           = "${var.project}-subnet-private"
    address_prefix = var.address_prefix_private
    security_group = azurerm_network_security_group.sg-private.id
  }

  # subnet {
  #   name           = "${var.project}-subnet-paas "
  #   address_prefix = "10.0.3.0/24"
  #   security_group = azurerm_network_security_group.sg-paas.id
  #   delegation {
  #     name = "aks"
  #     service_delegation {
  #       name    = "Microsoft.ContainerService/kubernetes"
  #       actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
  #     }
  #   }
  # }
}

resource "azurerm_network_security_group" "sg-public" {
  name                = "${var.project}-nsg-public"
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.security_rules_public

    content {
      name                        = security_rule.value.name
      priority                    = security_rule.value.priority
      direction                   = security_rule.value.direction
      access                      = security_rule.value.access
      protocol                    = security_rule.value.protocol
      source_port_range           = security_rule.value.source_port_range
      destination_port_range      = security_rule.value.destination_port_range
      source_address_prefix       = security_rule.value.source_address_prefix
      destination_address_prefix  = security_rule.value.destination_address_prefix
    }
  }
}

resource "azurerm_network_security_group" "sg-private" {
  name                = "${var.project}-nsg-private"
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.security_rules_private

    content {
      name                        = security_rule.value.name
      priority                    = security_rule.value.priority
      direction                   = security_rule.value.direction
      access                      = security_rule.value.access
      protocol                    = security_rule.value.protocol
      source_port_range           = security_rule.value.source_port_range
      destination_port_range      = security_rule.value.destination_port_range
      source_address_prefix       = security_rule.value.source_address_prefix
      destination_address_prefix  = security_rule.value.destination_address_prefix
    }
  }
}

resource "azurerm_network_security_group" "sg-paas" {
  name                = "${var.project}-nsg-paas "
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.security_rules_paas 

    content {
      name                        = security_rule.value.name
      priority                    = security_rule.value.priority
      direction                   = security_rule.value.direction
      access                      = security_rule.value.access
      protocol                    = security_rule.value.protocol
      source_port_range           = security_rule.value.source_port_range
      destination_port_range      = security_rule.value.destination_port_range
      source_address_prefix       = security_rule.value.source_address_prefix
      destination_address_prefix  = security_rule.value.destination_address_prefix
    }
  }
}

resource "azurerm_subnet" "paas_services" {
  name                 = "${var.project}-subnet-paas"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  delegation {
    name = "delegation"
    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
  }
  delegation {
    name = "delegation"
    service_delegation {
      name    = "Microsoft.DBforPostgreSQL/servers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "paas_services" {
  subnet_id                 = azurerm_subnet.paas_services.id
  network_security_group_id = azurerm_network_security_group.sg-paas.id
}




