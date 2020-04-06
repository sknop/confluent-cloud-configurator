// Copyright 2020 Confluent
// Contributors:
//   Sven Erik Knop sven@confluent.io
//   Christoph Schubert cschubert@confluent.io
//
// All rights reserved

// Base setups

variable "region" {
  type = string
  description = ""
}

variable "key_name" {
  type = string
  description = "Key name for cloud provider"
}

variable "ssh_key_path" {
  type = string
  default = "~/.ssh/terraform"
  description = "path to private ssh key to be inserted into all instances"
}

variable "owner" {
  type = string
  description = "Prefix for all resource names"
}

variable "admin_network" {
  default = "128.177.123.75"
  description = "My local network or bastion host, will be added to the security group rules"
}

// Number of services that will be created

variable "zk_count" {
  default = 1
}

variable "broker_count" {
  default = 1
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

// Type of services

variable zk_instance_type {
  default = "t2.micro"
}

variable broker_instance_type {
  default = "t2.micro"
}

variable connect_instance_type {
  default = "t2.medium"
}

variable schema_registry_instance_type {
  default = "t2.micro"
}

variable rest_proxy_instance_type {
  default = "t2.micro"
}

variable ksql_instance_type {
  default = "t2.micro"
}

variable c3_instance_type {
  default = "t2.medium"
}
