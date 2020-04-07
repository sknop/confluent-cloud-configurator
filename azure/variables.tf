// Copyright 2020 Confluent
// Contributors:
//   Sven Erik Knop sven@confluent.io
//   Christoph Schubert cschubert@confluent.io
//
// All rights reserved

variable "resource_group_name" {
  type = string
  default = "CP-cluster"
}

variable "location" {
  default = "westeurope"
}

variable "owner" {
  default = "Christoph"
}

variable "ssh_key" {
  type = string
  default = "~/.ssh/terraform.pub"
}

//TODO: split this up by roles
variable "vm_size" {
  default = "Standard_B1s"
}
