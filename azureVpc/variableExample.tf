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

variable "vnet_name" {
  type    = string
  default = "vnet-terraform-azure"

}
variable "subnet_name" {
  type    = string
  default = "subnet-terraform-azure"

}
variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "subnet_address_prefixes" {
  type    = list(string)
  default = ["10.0.0.0/24"]
}

variable "network_interface_name" {
  type    = string
  default = "nic-terraform-azure"

}
variable "ip_configuration" {
  type    = string
  default = "ipconfig1"
}
variable "private_ip_address_allocation_type" {
  type    = string
  default = "Dynamic"
}

variable "public_ip_allocation_method" {
  type    = string
  default = "Static"
}

variable "public_ip_name" {
  type    = string
  default = "publicip-terraform-azure"
}

variable "security_group_name" {
  type    = string
  default = "nsg-terraform-azure"
}
