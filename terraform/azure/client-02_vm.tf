resource "azurerm_virtual_machine" "client-02" {
  name = "client-02"
  location = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  vm_size = "Standard_A3"

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
    computer_name = "client-1"
    admin_username = var.Admin_Username
    admin_password = var.Admin_Password
  }

  network_interface_ids = [
    azurerm_network_interface.client-02-mgmt.id]

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_network_interface" "client-02-mgmt" {
  name = "client-02eth0"
  location = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  ip_configuration {
    name = "client-02eth0"
    subnet_id = azurerm_subnet.management.id
    private_ip_address_allocation = "Static"
    private_ip_address = var.client_02_mgmt_ip
  }
}

resource "azurerm_network_interface" "client-02-data" {
  name = "client-02-eth1"
  location = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  ip_configuration {
    name = "client-02-eth1"
    subnet_id = azurerm_subnet.trust.id
    private_ip_address_allocation = "Static"
    private_ip_address = var.client_02_trust_ip
  }
}
