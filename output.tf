// Copyright 2020 Confluent
// Contributors:
//   Sven Erik Knop sven@confluent.io
//   Christoph Schubert cschubert@confluent.io
//
// All rights reserved

// Output

output "zookeeper_public_dns" {
  value = aws_instance.zookeepers.*.public_dns
}

output "zookeeper_tags" {
  value = aws_instance.zookeepers.*.tags
}

output "broker_public_dns" {
  value = aws_instance.brokers.*.public_dns
}

output "broker_tags" {
  value = aws_instance.brokers.*.tags
}


output "broker_az" {
  value = aws_instance.brokers.*.availability_zone
}


output "schema_registry_public_dns" {
  value = aws_instance.schema_registry.*.public_dns
}

output "rest_proxy_public_dns" {
  value = aws_instance.rest_proxy.*.public_dns
}

output "ksql_public_dns" {
  value = aws_instance.ksql.*.public_dns
}

output "connect_public_dns" {
  value = aws_instance.connect-cluster.*.public_dns
}

output "c3_public_dns" {
  value = aws_instance.c3.*.public_dns
}
