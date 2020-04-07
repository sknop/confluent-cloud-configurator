// Copyright 2020 Confluent
// Contributors:
//   Sven Erik Knop sven@confluent.io
//   Christoph Schubert cschubert@confluent.io
//
// All rights reserved

output "vm_public_ip" {
     value = azurerm_public_ip.cp_broker.*.ip_address
}
