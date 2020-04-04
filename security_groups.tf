// Copyright 2020 Confluent
// Contributors:
//   Sven Erik Knop sven@confluent.io
//   Christoph Schubert cschubert@confluent.io
//
// All rights reserved

// Security Groups

resource "aws_security_group" "ssh" {
  description = "Managed by Terraform"
  name = "${var.owner}-ssh"

  # Allow ping from my ip and self
  ingress {
    from_port = 8
    to_port = 0
    protocol = "icmp"
    self = true
    cidr_blocks = [local.myip-cidr]
  }

  # ssh from me and self
  ingress {
    from_port = 22
    to_port = 22
    protocol = "TCP"
    self = true
    cidr_blocks = [local.myip-cidr]
  }

  # ssh from anywhere
  ingress {
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "zookeepers" {
  description = "Zookeeper security group - Managed by Terraform"
  name = "${var.owner}-zookeepers"

  ingress {
    from_port = 2181
    to_port = 2181
    protocol = "TCP"
    security_groups = [
      aws_security_group.brokers.id,
      aws_security_group.connect.id,
    ]
    cidr_blocks = [local.myip-cidr]
  }

  ingress {
    from_port = 2888
    to_port = 2888
    protocol = "TCP"
    self = true
  }

  ingress {
    from_port = 3888
    to_port = 3888
    protocol = "TCP"
    self = true
  }
}

resource "aws_security_group" "brokers" {
  description = "brokers - Managed by Terraform"
  name = "${var.owner}-brokers"

  # allow clients from anywhere - temporary for follower cluster in frankfurt - should get their submet range from terraform
  # 9092-9095 for all broker protocols
  ingress {
    from_port = 9091
    to_port = 9091
    protocol = "TCP"
    self = true
  }

  # client connections from ssh hosts, connect, schema, my ip, clients
  ingress {
    from_port = 9092
    to_port = 9096
    protocol = "TCP"
    self = true
    security_groups = [
      aws_security_group.connect.id,
      aws_security_group.schema.id,
      aws_security_group.ksql.id,
      aws_security_group.c3.id
    ]
    cidr_blocks = [local.myip-cidr]
  }
}

resource "aws_security_group" "connect" {
  description = "Connect security group - Managed by Terraform"
  name = "${var.owner}-connect"

  # connect http interface - only accessable on host, without this
  # c3 needs access
  ingress {
    from_port = 8083
    to_port = 8083
    protocol = "TCP"
    self = true
    security_groups = [
      aws_security_group.c3.id,
    ]
  }
}

resource "aws_security_group" "schema" {
  description = "Schema security group - Managed by Terraform"
  name = "${var.owner}-schema"

  ingress {
    from_port = 8081
    to_port = 8081
    protocol = "TCP"
    self = true
    security_groups = [
      aws_security_group.c3.id,
      aws_security_group.ssh.id,
      aws_security_group.connect.id,
      aws_security_group.ksql.id,
    ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rest_proxy" {
  description = "REST Proxy security group - Managed by Terraform"
  name = "${var.owner}-rest-proxy"

  # web ui
  ingress {
    from_port = 8082
    to_port = 8082
    protocol = "TCP"
    security_groups = [aws_security_group.ssh.id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ksql" {
  description = "KSQL security group - Managed by Terraform"
  name = "${var.owner}-ksql"

  # web ui
  ingress {
    from_port = 8088
    to_port = 8088
    protocol = "TCP"
    cidr_blocks = [local.myip-cidr]
    security_groups = [aws_security_group.c3.id, aws_security_group.ssh.id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "c3" {
  description = "C3 security group - Managed by Terraform"
  name = "${var.owner}-c3"

  # web ui
  ingress {
    from_port = 9021
    to_port = 9021
    protocol = "TCP"
    cidr_blocks = [local.myip-cidr]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}