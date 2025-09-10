//output the network interface id
output "network_interface_id" {
  value = azurerm_network_interface.nic_terraform.id
}

output "public_ip_address" {
  value = azurerm_public_ip.public_ip.ip_address

}
output "vnet_id" {
  value = azurerm_virtual_network.vnet_terraform.id
}
output "subnet_id" {
  value = azurerm_subnet.subnet_terraform.id

}
