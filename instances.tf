// Resources

resource "aws_instance" "zookeepers" {
  count         = var.zk_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.zk_instance_type
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  security_groups = [
    aws_security_group.ssh.name, aws_security_group.zookeepers.name]
  key_name = var.key_name
  tags = {
    Name = "${var.owner}-zookeeper-${count.index}-${element(data.aws_availability_zones.available.names, count.index)}"
    description = "zookeeper nodes - Managed by Terraform"
    role = "zookeeper"
    zookeeperid = count.index
    Owner = var.owner
    sshUser = "ubuntu"
    region = var.region
    role_region = "zookeepers-${var.region}"
  }
}

resource "aws_instance" "brokers" {
  count         = var.broker_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.broker_instance_type
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  # security_groups = ["${var.security_group}"]
  security_groups = [
    aws_security_group.brokers.name, "${aws_security_group.ssh.name}"]
  key_name = var.key_name
  root_block_device {
    volume_size = 1000 # 1TB
  }
  tags = {
    Name = "${var.owner}-broker-${count.index}-${element(data.aws_availability_zones.available.names, count.index)}"
    description = "broker nodes - Managed by Terraform"
    nice-name = "kafka-${count.index}"
    big-nice-name = "follower-kafka-${count.index}"
    brokerid = count.index
    role = "broker"
    owner = var.owner
    sshUser = "ubuntu"
    # sshPrivateIp = true // this is only checked for existence, not if it's true or false by terraform.py (ati)
    createdBy = "terraform"
    # ansible_python_interpreter = "/usr/bin/python3"
    #EntScheduler = "mon,tue,wed,thu,fri;1600;mon,tue,wed,thu;fri;sat;0400;"
    region = var.region
    role_region = "brokers-${var.region}"
  }
}

resource "aws_instance" "connect-cluster" {
  count         = var.connect_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.connect_instance_type
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  security_groups = [aws_security_group.ssh.name, aws_security_group.connect.name]
  key_name = var.key_name
  tags = {
    Name = "${var.owner}-connect-${count.index}-${element(data.aws_availability_zones.available.names, count.index)}"
    description = "Connect nodes - Managed by Terraform"
    role = "connect"
    Owner = var.owner
    sshUser = "ubuntu"
    region = var.region
    role_region = "connect-${var.region}"
  }
}

resource "aws_instance" "schema" {
  count         = var.schema_registry_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.schema_registry_instance_type
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  security_groups = [
    aws_security_group.ssh.name, aws_security_group.schema.name]
  key_name = var.key_name
  tags = {
    Name = "${var.owner}-schema-${count.index}-${element(data.aws_availability_zones.available.names, count.index)}"
    description = "Schema nodes - Managed by Terraform"
    role = "schema"
    Owner = var.owner
    sshUser = "ubuntu"
    region = var.region
    role_region = "schema-${var.region}"
  }
}

resource "aws_instance" "ksql" {
  count         = var.ksql_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.ksql_instance_type
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  security_groups = ["${aws_security_group.ssh.name}", "${aws_security_group.ksql.name}"]
  key_name = var.key_name
  tags = {
    Name = "${var.owner}-ksql-${count.index}-${element(data.aws_availability_zones.available.names, count.index)}"
    description = "KSQL nodes - Managed by Terraform"
    role = "ksql"
    Owner = var.owner
    sshUser = "ubuntu"
    region = var.region
    role_region = "ksql-${var.region}"
  }
}

resource "aws_instance" "c3" {
  count         = var.c3_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.c3_instance_type
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  security_groups = [aws_security_group.ssh.name, aws_security_group.c3.name]
  key_name = var.key_name
  tags = {
    Name = "${var.owner}-c3-${count.index}-${element(data.aws_availability_zones.available.names, count.index)}"
    description = "C3 nodes - Managed by Terraform"
    role = "c3"
    Owner = var.owner
    sshUser = "ubuntu"
    region = var.region
    role_region = "schema-${var.region}"
  }
}
