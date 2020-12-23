resource "azurerm_network_security_group" "PAN_FW_NSG" {
  name = "DefaultNSG"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  location = azurerm_resource_group.resourcegroup.location

  security_rule {
    name = "Allow-22"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "*"
    source_port_range = "*"
    destination_port_range = "22"
    source_address_prefix = "*"
    destination_address_prefix = var.fw_mgmt_ip
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
  network_security_group_id = azurerm_network_security_group.PAN_FW_NSG.id
}

resource "azurerm_subnet_network_security_group_association" "untrust" {
  subnet_id = azurerm_subnet.untrust.id
  network_security_group_id = azurerm_network_security_group.PAN_FW_NSG.id
}

resource "azurerm_subnet_network_security_group_association" "trust" {
  subnet_id = azurerm_subnet.trust.id
  network_security_group_id = azurerm_network_security_group.PAN_FW_NSG.id
}
