//create the resource group for the vpc 
resource "azurerm_resource_group" "resource_group_terraform" {
  name     = var.resource_group_name
  location = var.location
}

//create the public ip address 
resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_name
  resource_group_name = azurerm_resource_group.resource_group_terraform.name
  location            = azurerm_resource_group.resource_group_terraform.location
  allocation_method   = var.public_ip_allocation_method
  sku                 = "Standard"
}



//create the virtual network 

resource "azurerm_virtual_network" "vnet_terraform" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.resource_group_terraform.location
  resource_group_name = azurerm_resource_group.resource_group_terraform.name
}

//  create the subnet 

resource "azurerm_subnet" "subnet_terraform" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.resource_group_terraform.name
  virtual_network_name = azurerm_virtual_network.vnet_terraform.name
  address_prefixes     = var.subnet_address_prefixes
}

//network interface controller
resource "azurerm_network_interface" "nic_terraform" {
  name                = var.network_interface_name
  location            = azurerm_resource_group.resource_group_terraform.location
  resource_group_name = azurerm_resource_group.resource_group_terraform.name

  ip_configuration {
    name                          = var.ip_configuration
    subnet_id                     = azurerm_subnet.subnet_terraform.id
    private_ip_address_allocation = var.private_ip_address_allocation_type
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

//creating the security group for the subnet itself 
resource "azurerm_network_security_group" "terraform_security_group" {
  name                = var.security_group_name
  location            = azurerm_resource_group.resource_group_terraform.location
  resource_group_name = azurerm_resource_group.resource_group_terraform.name
}

// security rules for the security group
resource "azurerm_network_security_rule" "security_outbound_rules" {
  name                        = "security_outbound_rules"
  priority                    = 200
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.resource_group_terraform.name
  network_security_group_name = azurerm_network_security_group.terraform_security_group.name
}

resource "azurerm_network_security_rule" "security_inbound_rule" {
  name                        = "security_inbound_rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["22", "80", "443"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.resource_group_terraform.name
  network_security_group_name = azurerm_network_security_group.terraform_security_group.name
}
//subnet association with the security group
resource "azurerm_subnet_network_security_group_association" "subnet_association" {
  subnet_id                 = azurerm_subnet.subnet_terraform.id
  network_security_group_id = azurerm_network_security_group.terraform_security_group.id
}

