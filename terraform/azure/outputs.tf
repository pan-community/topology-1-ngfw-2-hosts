output "ngfw_ip_address" {
  value = azurerm_public_ip.fw_mgmt_ip.ip_address
}

output "jumphost_ip_address" {
  value = azurerm_public_ip.jumphost_mgmt_ip.ip_address
}

output "client_01_trust_ip" {
  value = azurerm_network_interface.client-01-eth0.private_ip_address
}

output "client_02_dmz_ip" {
  value = azurerm_network_interface.client-02-eth0.private_ip_address
}

output "fw_mgmt_ip" {
  value = azurerm_network_interface.fw_mgmt.private_ip_address
}

output "fw_dmz_ip" {
  value = azurerm_network_interface.fw_dmz.private_ip_address
}

output "fw_trust_ip" {
  value = azurerm_network_interface.fw_trust.private_ip_address
}

output "fw_untrust_ip" {
  value = azurerm_network_interface.fw_untrust.private_ip_address
}

output "jumphost_mgmt_ip" {
  value = azurerm_network_interface.jumphost-eth0.private_ip_address
}

output "untrust_subnet_cidr" {
  value = azurerm_subnet.untrust.address_prefixes[0]
}

output "trust_subnet_cidr" {
  value = azurerm_subnet.trust.address_prefixes[0]
}

output "dmz_subnet_cidr" {
  value = azurerm_subnet.dmz.address_prefixes[0]
}

