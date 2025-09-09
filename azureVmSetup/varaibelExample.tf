variable "subscription_id" {
  type    = string
  default = "<subscription_id>"
}
variable "location" {
  type    = string
  default = "East Asia"

}
variable "resource_group_name" {
  type    = string
  default = "rg-terraform-azure-vpc"

}
variable "virtual_machine_name" {
  type    = string
  default = "vm-terraform-azure"

}

variable "network_interface_id" {
  type    = string
  default = "<your-resource-id>"

}
