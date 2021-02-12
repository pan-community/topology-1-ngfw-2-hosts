output "ngfw_ip_address" {
  value = azurerm_public_ip.fw_mgmt_ip.ip_address
}

output "jumphost_ip_address" {
  value = azurerm_public_ip.jumphost_mgmt_ip.ip_address
}

