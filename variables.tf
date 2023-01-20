variable "name" {
  description = "Environment/Name prefix for resources"
  type        = string
}

variable "folder_id" {
  description = "Folder_id where to create resources"
  type        = string
  default     = null
}

variable "labels" {
  description = "Map of labels for resources"
  type        = map(string)
  default     = {}
}

variable "description" {
  description = "Description template for resources"
  type        = string
  default     = "Managed"
}

variable "enable_nat_global" {
  description = "Global enable NAT Gateway. Must be set if nat='true' in var.subnets params"
  type        = bool
  default     = false
}

variable "enable_route_table" {
  description = "Enable custom route table"
  type        = bool
  default     = false
}

variable "routes" {
  description = "Create custom routes"
  type = list(object({
    destination_prefix = string,
    next_hop_address   = string,
  }))
  default = []
}

variable "subnets" {
  description = "Map of subnets with params"
  type = map(object({
    zone        = string
    cidr_blocks = list(string)
    nat         = optional(bool, false)
  }))
  default = {
    subnet-a = {
      zone        = "ru-central1-a"
      cidr_blocks = ["10.1.0.0/24"]
      nat         = false
    },
    subnet-b = {
      zone        = "ru-central1-b"
      cidr_blocks = ["10.2.0.0/24"]
      nat         = false
    },
    subnet-c = {
      zone        = "ru-central1-c"
      cidr_blocks = ["10.3.0.0/24"]
      nat         = false
    }
  }
}
