// Copyright 2020 Confluent
// Contributors:
//   Sven Erik Knop sven@confluent.io
//   Christoph Schubert cschubert@confluent.io
//
// All rights reserved

// Output

output "zookeepers" {
  value = zipmap(aws_instance.zookeepers.*.public_dns,aws_instance.zookeepers.*.tags)
}

output "brokers" {
  value = zipmap(aws_instance.brokers.*.public_dns,aws_instance.brokers.*.tags)
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
