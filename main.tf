# Specify the provider and version
provider "azurerm" {
  resource_provider_registrations = "none"
  features {}
 
    # Use variables to authenticate
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}


data "azurerm_resource_group" "resource_group" {
  name = var.resource_group
}

# Define the network interface
resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.resource_name}-nic"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
 
  ip_configuration {
    name                          = "internal"
    subnet_id                     = "/subscriptions/${var.subscription_id}/resourceGroups/${var.vnet_resource_group}/providers/Microsoft.Network/virtualNetworks/${var.vnet_name}/subnets/${var.subnet_name}"
    private_ip_address_allocation = "Dynamic"
  }
}
 
# Define the virtual machine
resource "azurerm_virtual_machine" "virtual_machine" {
  name                = var.resource_name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = data.azurerm_resource_group.resource_group.location
  vm_size                = var.vm_size
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id
  ]
 
  storage_os_disk {
    name              = "${var.resource_name}-osdisk"
    caching           = var.os_disk_caching
    create_option     = "FromImage"
    disk_size_gb      = var.os_disk_size_gb
  }
 
  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
 
  os_profile {
    computer_name  = var.resource_name
    admin_username = "superuser"
    admin_password = "AdminPass2024*" 
  }
 
  os_profile_windows_config {
    provision_vm_agent = true
  }
 
  tags = {
    environment = var.stage
    resource_owner = "sfallas"
  }
}