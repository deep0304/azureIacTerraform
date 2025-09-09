

resource "azurerm_resource_group" "resource_group_terraform" {
  name     = var.resource_group_name
  location = var.location
}
resource "azurerm_virtual_network" "vnet_terraform" {
  name                = "vnet-terraform-azure"
  location            = azurerm_resource_group.resource_group_terraform.location
  resource_group_name = azurerm_resource_group.resource_group_terraform.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet_terraform" {
  name                 = "subnet-terraform-azure"
  resource_group_name  = azurerm_resource_group.resource_group_terraform.name
  virtual_network_name = azurerm_virtual_network.vnet_terraform.name
  address_prefixes     = ["10.0.0.0/24"]
}



resource "azurerm_linux_virtual_machine" "virtual_machine" {
  name                = var.virtual_machine_name
  resource_group_name = azurerm_resource_group.resource_group_terraform.name
  location            = azurerm_resource_group.resource_group_terraform.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    var.network_interface_id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.virtual_machine.public_ip_address

}
