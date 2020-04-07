output "broker" {
    value = module.broker_nodes.public_ip_dns_name
}

output "vm_public_ip" {
    value = module.broker_nodes.public_ip_address
}

output "vm_private_ips" {
    value = module.broker_nodes.network_interface_private_ip
}
