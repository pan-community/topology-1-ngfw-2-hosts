
resource "azurerm_virtual_machine" "firewall" {
  name = "firewall"
  location = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  network_interface_ids = [
    azurerm_network_interface.fwmanagement.id,
    azurerm_network_interface.fwuntrust.id,
    azurerm_network_interface.fwtrust.id
  ]

  primary_network_interface_id = azurerm_network_interface.fwmanagement.id
  vm_size = "Standard_D3_v2"

  plan {
    name = "bundle2"
    publisher = "paloaltonetworks"
    product = "vmseries1"
  }

  storage_image_reference {
    publisher = "paloaltonetworks"
    offer = "vmseries1"
    sku = "bundle2"
    version = "9.1.2" # can also use 'latest' here as well
  }

  storage_os_disk {
    name = "firewall-disk"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  os_profile {
    computer_name = "pa-vm"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_network_interface" "fwmanagement" {
  name = "fwmanagement"
  location = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  ip_configuration {
    name = "fweth0"
    subnet_id = azurerm_subnet.management.id
    private_ip_address_allocation = "Static"
    private_ip_address = var.fw_mgmt_ip
    public_ip_address_id = azurerm_public_ip.fwmanagement.id
  }
  depends_on = [azurerm_public_ip.fwmanagement]
}

resource "azurerm_network_interface" "fwuntrust" {
  name = "fwuntrust"
  location = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  enable_ip_forwarding = "true"
  ip_configuration {
    name = "fweth1"
    subnet_id = azurerm_subnet.untrust.id
    private_ip_address_allocation = "Static"
    private_ip_address = var.fw_untrust_ip
  }
}

resource "azurerm_network_interface" "fwtrust" {
  name = "fwtrust"
  location = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  enable_ip_forwarding = "true"
  ip_configuration {
    name = "fweth2"
    subnet_id = azurerm_subnet.trust.id
    private_ip_address_allocation = "Static"
    private_ip_address = var.fw_trust_ip
  }
}
