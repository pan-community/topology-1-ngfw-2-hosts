resource "azurerm_virtual_machine" "jumphost" {
  name = "jumphost"
  location = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  vm_size = "Standard_A1"

  storage_image_reference {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "18.04-LTS"
    version = "latest"
  }

  storage_os_disk {
    name = "jumphost-disk"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name = "jumphost"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  network_interface_ids = [
    azurerm_network_interface.jumphost-eth0.id
  ]

  primary_network_interface_id = azurerm_network_interface.jumphost-eth0.id

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_network_interface" "jumphost-eth0" {
  name = "jumphost-eth0"
  location = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  ip_configuration {
    name = "jumphost-eth0"
    subnet_id = azurerm_subnet.management.id
    private_ip_address_allocation = "Static"
    private_ip_address = var.jumphost_mgmt_ip
    public_ip_address_id = azurerm_public_ip.jumphost_mgmt_ip.id
  }
}
