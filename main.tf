// Copyright 2020 Confluent
// Contributors:
//   Sven Erik Knop sven@confluent.io
//   Christoph Schubert cschubert@confluent.io
//
// All rights reserved

resource "aws_key_pair" "ssh_key" {
  key_name   = var.key_name
  public_key = file("${var.ssh_key_path}.pub")
}


// Local variables

locals {
  myip-cidr = "${var.admin_network}/32"
}

// Provider

provider "aws" {
  profile    = "default"
  region     = var.region
}


// Search for available availibility zones (say it quickly three times)
data "aws_availability_zones" "available" {
  state = "available"
}
