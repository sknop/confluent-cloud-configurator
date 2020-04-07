// Copyright 2020 Confluent
// Contributors:
//   Sven Erik Knop sven@confluent.io
//   Christoph Schubert cschubert@confluent.io
//
// All rights reserved

resource "azurerm_virtual_network" "cp" {
 name                = "${var.owner}-cp-network"
 address_space       = ["10.0.0.0/16"]
 location            = azurerm_resource_group.cp.location
 resource_group_name = azurerm_resource_group.cp.name
}

resource "azurerm_subnet" "cp" {
 name                 = "${var.owner}-cp-subnet"
 resource_group_name  = azurerm_resource_group.cp.name
 virtual_network_name = azurerm_virtual_network.cp.name
 address_prefix       = "10.0.2.0/24"
}


resource "azurerm_subnet_network_security_group_association" "cp" {
  subnet_id                 = azurerm_subnet.cp.id
  network_security_group_id = azurerm_network_security_group.cp.id
}

resource "azurerm_network_security_group" "cp" {
  name                = "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.cp.location
  resource_group_name = azurerm_resource_group.cp.name
}



# NOTE: this allows SSH from any network --> needs to be changed immediately
resource "azurerm_network_security_rule" "ssh" {
  name                        = "ssh"
  resource_group_name         = azurerm_resource_group.cp.name
  network_security_group_name = azurerm_network_security_group.cp.name
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}

resource "azurerm_public_ip" "cp_broker" {
  count = var.broker_count
  name                         = "${var.owner}-cp-public-ip-${count.index}"
  location                     = azurerm_resource_group.cp.location
  resource_group_name          = azurerm_resource_group.cp.name
  allocation_method            = "Static"
}
