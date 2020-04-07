// Copyright 2020 Confluent
// Contributors:
//   Sven Erik Knop sven@confluent.io
//   Christoph Schubert cschubert@confluent.io
//
// All rights reserved

// Contains definitions of instances and related resources (disks, network interfaces)

resource "azurerm_network_interface" "broker" {
 count               = 3
 name                = "${var.owner}-${count.index}"
 location            = azurerm_resource_group.cp.location
 resource_group_name = azurerm_resource_group.cp.name

 ip_configuration {
   name                          = "testConfiguration"
   subnet_id                     = azurerm_subnet.cp.id
   private_ip_address_allocation = "dynamic"
   public_ip_address_id = element(azurerm_public_ip.cp.*.id, count.index)
 }
}

resource "azurerm_managed_disk" "cp" {
 count                = 3
 name                 = "${var.owner}-datadisk_existing_${count.index}"
 location             = azurerm_resource_group.cp.location
 resource_group_name  = azurerm_resource_group.cp.name
 storage_account_type = "Standard_LRS"
 create_option        = "Empty"
 disk_size_gb         = "10"
}


resource "azurerm_virtual_machine" "broker" {
  count                 = 3
  name                  = "${var.owner}-${count.index}"
  location              = azurerm_resource_group.cp.location
  resource_group_name   = azurerm_resource_group.cp.name
  network_interface_ids = [element(azurerm_network_interface.broker.*.id, count.index)]
  vm_size               = var.vm_size

 # Uncomment this line to delete the OS disk automatically when deleting the VM
 # delete_os_disk_on_termination = true

 # Uncomment this line to delete the data disks automatically when deleting the VM
 # delete_data_disks_on_termination = true

 storage_image_reference {
   publisher = "Canonical"
   offer     = "UbuntuServer"
   sku       = "16.04-LTS"
   version   = "latest"
 }

os_profile_linux_config {
  disable_password_authentication = false
  ssh_keys {
    key_data = file(var.ssh_key)


    path = "/home/azureuser/.ssh/authorized_keys"
  }
}

os_profile {
  computer_name  = "${var.owner}-broker-${count.index}"
  admin_username = "azureuser"
  admin_password = "Password1234!"
}

 storage_os_disk {
   name              = "${var.owner}-osdisk${count.index}"
   caching           = "ReadWrite"
   create_option     = "FromImage"
   managed_disk_type = "Standard_LRS"
 }

 # Optional data disks
 storage_data_disk {
   name              = "${var.owner}-datadisk_new_${count.index}"
   managed_disk_type = "Standard_LRS"
   create_option     = "Empty"
   lun               = 0
   disk_size_gb      = "10"
 }

 storage_data_disk {
   name            = element(azurerm_managed_disk.cp.*.name, count.index)
   managed_disk_id = element(azurerm_managed_disk.cp.*.id, count.index)
   create_option   = "Attach"
   lun             = 1
   disk_size_gb    = element(azurerm_managed_disk.cp.*.disk_size_gb, count.index)
 }


 tags = {
   environment = "staging"
 }
}
