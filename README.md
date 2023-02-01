### Yandex.Cloud Terraform VPC module
Provided as is. Make sure you check what it does before apply.
<!-- BEGIN_TF_DOCS -->

## Example

```hcl
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
    subnet-a = {
      zone        = "ru-central1-a",
      cidr_blocks = ["10.1.0.0/24"],
      nat         = true
    },
    subnet-b = { zone = "ru-central1-b", cidr_blocks = ["10.2.0.0/24"] },
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.78.0 |

## Usage
Basic usage of this module is as follows:

```hcl
module "example" {
	 source  = "github.com/iganosaigo/terraform-yandex-vpc.git"

	 # Required variables
	 name  = 

	 # Optional variables
	 description  = "Managed"
	 enable_nat_global  = false
	 enable_route_table  = false
	 folder_id  = null
	 labels  = {}
	 routes  = []
	 subnets  = {
  "subnet-a": {
    "cidr_blocks": [
      "10.1.0.0/24"
    ],
    "nat": false,
    "zone": "ru-central1-a"
  },
  "subnet-b": {
    "cidr_blocks": [
      "10.2.0.0/24"
    ],
    "nat": false,
    "zone": "ru-central1-b"
  },
  "subnet-c": {
    "cidr_blocks": [
      "10.3.0.0/24"
    ],
    "nat": false,
    "zone": "ru-central1-c"
  }
}
}
```

## Resources

| Name | Type |
|------|------|
| [yandex_vpc_gateway.nat](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_gateway) | resource |
| [yandex_vpc_network.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_network) | resource |
| [yandex_vpc_route_table.nat](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_route_table) | resource |
| [yandex_vpc_route_table.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_route_table) | resource |
| [yandex_vpc_subnet.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description template | `string` | `"Managed"` | no |
| <a name="input_enable_nat_global"></a> [enable\_nat\_global](#input\_enable\_nat\_global) | Global enable NAT. Must be set if nat='true' in var.subnets params | `bool` | `false` | no |
| <a name="input_enable_route_table"></a> [enable\_route\_table](#input\_enable\_route\_table) | Enable custom route table | `bool` | `false` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | Folder ID | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of labels | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Environment/Name prefix for resources | `string` | n/a | yes |
| <a name="input_routes"></a> [routes](#input\_routes) | Create custom routes | <pre>list(object({<br>    destination_prefix = string,<br>    next_hop_address   = string,<br>  }))</pre> | `[]` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Map of subnets with params | <pre>map(object({<br>    zone        = string<br>    cidr_blocks = list(string)<br>    nat         = optional(bool, false)<br>  }))</pre> | <pre>{<br>  "subnet-a": {<br>    "cidr_blocks": [<br>      "10.1.0.0/24"<br>    ],<br>    "nat": false,<br>    "zone": "ru-central1-a"<br>  },<br>  "subnet-b": {<br>    "cidr_blocks": [<br>      "10.2.0.0/24"<br>    ],<br>    "nat": false,<br>    "zone": "ru-central1-b"<br>  },<br>  "subnet-c": {<br>    "cidr_blocks": [<br>      "10.3.0.0/24"<br>    ],<br>    "nat": false,<br>    "zone": "ru-central1-c"<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gateway"></a> [gateway](#output\_gateway) | Gateway Info |
| <a name="output_network"></a> [network](#output\_network) | Network info |
| <a name="output_rt"></a> [rt](#output\_rt) | Route table info |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | Subnets info |
<!-- END_TF_DOCS -->
