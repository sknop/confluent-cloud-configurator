// Copyright 2020 Confluent
// Contributors:
//   Sven Erik Knop sven@confluent.io
//   Christoph Schubert cschubert@confluent.io
//
// All rights reserved

resource "aws_key_pair" "ssh_key" {
  key_name   = var.key_name
  public_key = file("~/.ssh/terraform.pub")
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

// Search for AMI rather than hard coding its ID - currently hard coded
// TODO: Parameterize as variables to be able to configure from the outside

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

// Search for available availibility zones (say it quickly three times)

data "aws_availability_zones" "available" {
  state = "available"
}

