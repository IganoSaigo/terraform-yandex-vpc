output "network_id" {
  description = "The ID of the network"
  value       = yandex_vpc_network.this.id
}

output "subnet_ids" {
  description = "IDs of all created subnets"
  value       = [for subnet in yandex_vpc_subnet.this : subnet.id]
}

output "availability_zones" {
  description = "Availability zones of all created subnets"
  value       = [for subnet in yandex_vpc_subnet.this : subnet.zone]
}

output "subnets" {
  description = "Map of subnets with additional info"
  value = { for v in yandex_vpc_subnet.this : v.name => {
    "id"          = v.id,
    "name"        = v.name,
    "zone"        = v.zone,
    "cidr"        = v.v4_cidr_blocks,
    "nat_enabled" = v.route_table_id == yandex_vpc_route_table.nat.id ? true : false
    }
  }
}
