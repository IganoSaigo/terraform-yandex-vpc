### Yandex.Cloud Terraform VPC module
Provided as is. Make sure you check what it does before apply.

#### Example
```
module "vpc" {
  source    = "github.com/iganosaigo/terraform-yandex-vpc.git"
  name      = "some_vpc"
  folder_id = "some_folder_id"

  labels = {
    env = "some_env"
  }

  enable_nat_global  = true
  enable_route_table = true
  routes = [
    {
      destination_prefix = "1.1.1.0/24"
      next_hop_address   = "10.10.10.10"
    }
  ]

  subnets = {
    subnet-a = { zone = "ru-central1-a", cidr_blocks = ["10.1.0.0/24"], nat = true },
    subnet-b = { zone = "ru-central1-b", cidr_blocks = ["10.2.0.0/24"] },
  }
```

