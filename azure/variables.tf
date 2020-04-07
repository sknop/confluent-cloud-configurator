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

// Number of services that will be created

variable "zk_count" {
  default = 3
}

variable "broker_count" {
  default = 4
}

variable "connect_count" {
  default = 0
}

variable "schema_registry_count" {
  default = 0
}

variable "rest_proxy_count" {
  default = 0
}

variable "ksql_count" {
  default = 0
}

variable "c3_count" {
  default = 0
}

variable "ssh_key" {
  type = string
  default = "~/.ssh/terraform.pub"
}

//TODO: duplicate for other roles
variable "broker_vm_size" {
  default = "Standard_B1s"
}
