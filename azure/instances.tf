variable "resource_group" {
  type = string
  default = "TFmanagedRG"
}

variable "location" {
  default = "westeurope"
}

variable "ssh_key" {
  type = string
  default = "~/.ssh/terraform.pub"
}

resource "azurerm_resource_group" "myterraformgroup" {
    name     = var.resource_group
    location = var.location
}

module "broker_nodes" {
    source = "Azure/compute/azurerm"
    resource_group_name = azurerm_resource_group.myterraformgroup.name
    #location = var.location
    #admin_password = "ComplxP@assw0rd!"
    vm_os_simple = "UbuntuServer"
    delete_os_disk_on_termination = true # CHANGE THIS FOR PRODUCTION!

    ssh_key = var.ssh_key

    nb_instances = 1
    public_ip_dns = ["christoph-broker-machine"]
    vnet_subnet_id = module.network.vnet_subnets[0]
}

module "zookeeper_nodes" {
    source = "Azure/compute/azurerm"
    resource_group_name = azurerm_resource_group.myterraformgroup.name
    #location = var.location
    #admin_password = "ComplxP@assw0rd!"
    vm_os_simple = "UbuntuServer"
    delete_os_disk_on_termination = true # CHANGE THIS FOR PRODUCTION!

    ssh_key = var.ssh_key

    nb_instances = 1
    public_ip_dns = ["christoph-zookeeper-machine"]
    vnet_subnet_id = module.network.vnet_subnets[0]
}

module "network" {
    source = "Azure/network/azurerm"
    #location = var.location
    resource_group_name = azurerm_resource_group.myterraformgroup.name
    #allow_ssh_traffic = true
}
