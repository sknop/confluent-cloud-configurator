// Output

output "zookeeper_public_dns" {
  value = [aws_instance.zookeepers.*.public_dns]
}

output "broker_public_dns" {
  value = [aws_instance.brokers.*.tags.brokerid,aws_instance.brokers.*.public_dns]
}

output "connect_public_dns" {
  value = [aws_instance.connect-cluster.*.public_dns]
}

output "schema_public_dns" {
  value = [aws_instance.schema.*.public_dns]
}

output "ksql_public_dns" {
  value = [aws_instance.ksql.*.public_dns]
}

output "c3_public_dns" {
  value = [aws_instance.c3.*.public_dns]
}
