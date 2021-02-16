resource "azurerm_network_security_group" "nsg" {
  name = "default_nsg"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  location = azurerm_resource_group.resourcegroup.location

  security_rule {
    name = "Allow-all-22"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "*"
    source_port_range = "*"
    destination_port_range = "22"
    source_address_prefix = "*"
    destination_address_prefixes = [var.jumphost_mgmt_ip, var.fw_mgmt_ip]
  }

  security_rule {
    name = "Allow-443"
    priority = 101
    direction = "Inbound"
    access = "Allow"
    protocol = "*"
    source_port_range = "*"
    destination_port_range = "443"
    source_address_prefix = "*"
    destination_address_prefix = var.fw_mgmt_ip
  }
}

resource "azurerm_subnet_network_security_group_association" "management" {
  subnet_id = azurerm_subnet.management.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_security_group" "trust" {
  name = "trust"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  location = azurerm_resource_group.resourcegroup.location

  security_rule {
    name = "wide-open-inbound"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "*"
    source_port_range = "*"
    destination_port_range = "*"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name = "wide-open-outbound"
    priority = 100
    direction = "Outbound"
    access = "Allow"
    protocol = "*"
    source_port_range = "*"
    destination_port_range = "*"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "trust" {
  subnet_id = azurerm_subnet.trust.id
  network_security_group_id = azurerm_network_security_group.trust.id
}

resource "azurerm_network_security_group" "dmz" {
  name = "dmz"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  location = azurerm_resource_group.resourcegroup.location

  security_rule {
    name = "wide-open-inbound"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "*"
    source_port_range = "*"
    destination_port_range = "*"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name = "wide-open-outbound"
    priority = 100
    direction = "Outbound"
    access = "Allow"
    protocol = "*"
    source_port_range = "*"
    destination_port_range = "*"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "dmz" {
  subnet_id = azurerm_subnet.dmz.id
  network_security_group_id = azurerm_network_security_group.dmz.id
}

