resource "yandex_vpc_network" "this" {
  name        = "${var.name}-network"
  folder_id   = var.folder_id
  description = "${var.description} ${var.name} network"
  labels      = var.labels
}

locals {
  main_table = var.enable_route_table ? yandex_vpc_route_table.this.id : null
}

resource "yandex_vpc_subnet" "this" {
  for_each = var.subnets

  name           = each.key
  network_id     = yandex_vpc_network.this.id
  folder_id      = var.folder_id
  description    = "${var.description} subnet in ${each.value.zone} zone"
  zone           = each.value.zone
  v4_cidr_blocks = each.value.cidr_blocks
  route_table_id = (
    (each.value.nat && var.enable_nat_global)
    ? yandex_vpc_route_table.nat.id
    : local.main_table
  )
  labels = var.labels
}

resource "yandex_vpc_gateway" "nat" {
  name      = "nat"
  folder_id = var.folder_id
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "nat" {
  name       = "${var.name}-rt-nat"
  network_id = yandex_vpc_network.this.id
  folder_id  = var.folder_id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat.id
  }

  dynamic "static_route" {
    for_each = length(var.routes[*]) > 0 ? var.routes : []

    iterator = route
    content {
      destination_prefix = route.value.destination_prefix
      next_hop_address   = route.value.next_hop_address
    }
  }
}

resource "yandex_vpc_route_table" "this" {
  name       = "${var.name}-rt"
  network_id = yandex_vpc_network.this.id
  folder_id  = var.folder_id

  dynamic "static_route" {
    for_each = length(var.routes[*]) > 0 ? var.routes : []

    iterator = route
    content {
      destination_prefix = route.value.destination_prefix
      next_hop_address   = route.value.next_hop_address
    }
  }
}
