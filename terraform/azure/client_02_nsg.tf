resource "azurerm_network_security_group" "client_02_sg" {
  name = "client_02_sg"
  location = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name

  security_rule {
    name = "Allow-client-02-22"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "*"
    source_port_range = "*"
    destination_port_range = "22"
    source_address_prefix = "*"
    destination_address_prefix = var.client_02_mgmt_ip
  }

  security_rule {
    name = "Allow-client-02-443"
    priority = 101
    direction = "Inbound"
    access = "Allow"
    protocol = "*"
    source_port_range = "*"
    destination_port_range = "443"
    source_address_prefix = "*"
    destination_address_prefix = var.client_02_mgmt_ip
  }

  security_rule {
    name = "Allow-client-02-5000"
    priority = 102
    direction = "Inbound"
    access = "Allow"
    protocol = "*"
    source_port_range = "*"
    destination_port_range = "5000"
    source_address_prefix = "*"
    destination_address_prefix = var.client_02_mgmt_ip
  }
}

resource "azurerm_subnet_network_security_group_association" "client_02_sga" {
  subnet_id = azurerm_subnet.management.id
  network_security_group_id = azurerm_network_security_group.client_02_sg.id
}