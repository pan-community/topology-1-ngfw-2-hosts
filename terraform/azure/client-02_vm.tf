resource "azurerm_virtual_machine" "client-02" {
  name = "client-02"
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
    name = "client-02-disk"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name = "client-02"
    admin_username = var.admin_username
    admin_password = var.admin_password
    custom_data = data.template_cloudinit_config.cloud-init-data.rendered
  }

  network_interface_ids = [
    azurerm_network_interface.client-02-eth0.id
  ]

  primary_network_interface_id = azurerm_network_interface.client-02-eth0.id

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_network_interface" "client-02-eth0" {
  name = "client-02-eth0"
  location = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  ip_configuration {
    name = "client-02-eth0"
    subnet_id = azurerm_subnet.dmz.id
    private_ip_address_allocation = "Static"
    private_ip_address = var.client_02_dmz_ip
  }
}
