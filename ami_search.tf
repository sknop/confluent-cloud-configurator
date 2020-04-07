// Copyright 2020 Confluent
// Contributors:
//   Sven Erik Knop sven@confluent.io
//   Christoph Schubert cschubert@confluent.io
//
// All rights reserved

// usernames taken from https://alestic.com/2014/01/ec2-ssh-username/

//TODO: double check some of the image owners
//TODO: some of the images reference SSDs, should we look for more generic search criteria?
locals {
  ami_data_by_os = {
    ubuntu = {
      regex = "^ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-.*"
      image_owner = "099720109477" #CANONICAL
      ssh_user = "ubuntu"
    }
    ubuntu-14.04 = {
      regex = "^ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-.*"
      image_owner = "099720109477" #CANONICAL
      ssh_user = "ubuntu"
    }
    ubuntu-16.04= {
      regex = "^ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-.*"
      image_owner = "099720109477" #CANONICAL
      ssh_user = "ubuntu"
    }
    ubuntu-18.04 = {
      regex = "^ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-.*"
      image_owner = "099720109477" #CANONICAL
      ssh_user = "ubuntu"
    }
    ubuntu-18.10 = {
      regex = "^ubuntu/images/hvm-ssd/ubuntu-cosmic-18.10-amd64-server-.*"
      image_owner = "099720109477" #CANONICAL
      ssh_user = "ubuntu"
    }
    ubuntu-19.04 = {
      regex = "^ubuntu/images/hvm-ssd/ubuntu-disco-19.04-amd64-server-.*"
      image_owner = "099720109477" #CANONICAL
      ssh_user = "ubuntu"
    }
    centos-6 = {
      regex = "^CentOS.Linux.6.*x86_64.*"
      image_owner = "679593333241" # TODO: check
      ssh_user = "centos"
    }

    centos-7 = {
      regex = "^CentOS.Linux.7.*x86_64.*"
      image_owner = "679593333241" # TODO: check
      ssh_user = "centos"
    }

    centos-8 = {
      regex = "^CentOS.Linux.8.*x86_64.*"
      image_owner = "679593333241" # TODO: check
      ssh_user = "centos"
    }

    rhel-7  = {
      regex = "^RHEL-7.*x86_64.*"
      image_owner = "309956199498" #Amazon Web Services
      ssh_user = "ec2-user"
    }

    rhel-8 = {
      regex =  "^RHEL-8.*x86_64.*"
      image_owner = "309956199498" #Amazon Web Services
      ssh_user = "ec2-user"
    }

    debian-8 = {
      regex = "^debian-jessie-.*"
      image_owner = "679593333241" # TODO: check
      ssh_user = "admin"
    }

    debian-9  = {
      regex = "^debian-stretch-.*"
      image_owner = "679593333241" //TODO: check
      ssh_user = "admin"
    }
    debian-10 = {
      regex = "^debian-10-.*"
      image_owner = "136693071363" //TODO: check
      ssh_user = "admin"
    }
    fedora-27 = {
      regex = "^Fedora-Cloud-Base-27-.*-gp2.*"
      image_owner = "125523088429" #Fedora
      ssh_user = "fedora"
    }
    amazon = {
      regex = "^amzn-ami-hvm-.*x86_64-gp2"
      image_owner = "137112412989" #amazon
      ssh_user = "ec2-user"
    }
    amazon-2_lts = {
      regex = "^amzn2-ami-hvm-.*x86_64-gp2"
      image_owner = "137112412989" #amazon
      ssh_user = "ec2-user"
    }
    suse-les-12 = {
      regex = "^suse-sles-12-sp\\d-v\\d{8}-hvm-ssd-x86_64"
      image_owner = "013907871322" #amazon
      ssh_user = "ec2-user"
    }
  }
}


data "aws_ami" "latest_by_os" {
  most_recent = true
  name_regex = local.ami_data_by_os[var.os]["regex"]
  owners = [local.ami_data_by_os[var.os]["image_owner"]]
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}


output "ssh_username" {
  value = local.ami_data_by_os[var.os]["ssh_user"]
}
