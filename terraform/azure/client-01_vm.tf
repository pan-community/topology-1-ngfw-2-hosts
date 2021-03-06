resource "azurerm_virtual_machine" "client-01" {
  name = "client-01"
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
    name = "client-01-disk"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name = "client-01"
    admin_username = var.admin_username
    admin_password = var.admin_password
    custom_data = data.template_cloudinit_config.cloud-init-data.rendered

  }

  network_interface_ids = [
    azurerm_network_interface.client-01-eth0.id
  ]

  primary_network_interface_id = azurerm_network_interface.client-01-eth0.id

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_network_interface" "client-01-eth0" {
  name = "client-01-eth0"
  location = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  ip_configuration {
    name = "client-01-eth0"
    subnet_id = azurerm_subnet.trust.id
    private_ip_address_allocation = "Static"
    private_ip_address = var.client_01_trust_ip
  }
}
