// Copyright 2020 Confluent
// Contributors:
//   Sven Erik Knop sven@confluent.io
//   Christoph Schubert cschubert@confluent.io
//
// All rights reserved

// Output a map for each role:
// - keys: public FQDN of a node
// - values: all tags of the corresponding instance

output "zookeepers" {
  value = zipmap(aws_instance.zookeepers.*.public_dns, aws_instance.zookeepers.*.tags)
}

output "brokers" {
  value = zipmap(aws_instance.brokers.*.public_dns, aws_instance.brokers.*.tags)
}

output "schema_registry" {
    value = zipmap(aws_instance.schema_registry.*.public_dns, aws_instance.schema_registry.*.tags)
}

output "rest_proxy" {
    value = zipmap(aws_instance.rest_proxy.*.public_dns, aws_instance.rest_proxy.*.tags)
}

output "ksql" {
    value = zipmap(aws_instance.ksql.*.public_dns, aws_instance.ksql.*.tags)
}

output "connect" {
    value = zipmap(aws_instance.connect-cluster.*.public_dns, aws_instance.connect-cluster.*.tags)
}

output "c3" {
    value = zipmap(aws_instance.c3.*.public_dns, aws_instance.c3.*.tags)
}
