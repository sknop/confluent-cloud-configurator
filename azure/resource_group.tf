resource "azurerm_resource_group" "cp" {
 name     = "${var.owner}-${var.resource_group_name}"
 location = var.location
}
