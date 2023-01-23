output "network" {
  description = "Network info"
  value       = yandex_vpc_network.this
}

output "subnets" {
  description = "Subnets info"
  value = ({
    for subnet in yandex_vpc_subnet.this :
    subnet.name => merge(
      subnet, {
        "nat_enabled" = (
          subnet.route_table_id == yandex_vpc_route_table.nat.id
          ? true
          : false
        )
      }
    )
  })
}

output "rt" {
  value = {
    "rt_main" = yandex_vpc_route_table.this,
    "rt_nat"  = yandex_vpc_route_table.nat
  }
}

output "gateway" {
  value = yandex_vpc_gateway.nat
}
