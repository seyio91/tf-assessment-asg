## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.47 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.47 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_endpoints"></a> [endpoints](#module\_endpoints) | terraform-aws-modules/vpc/aws//modules/vpc-endpoints | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 4.0 |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | (Required) Resource Tag | `map(any)` | n/a | yes |
| <a name="input_customer"></a> [customer](#input\_customer) | (Required) Name of Customer. ex: Fiter | `string` | n/a | yes |
| <a name="input_enable_karpenter_autoscaler"></a> [enable\_karpenter\_autoscaler](#input\_enable\_karpenter\_autoscaler) | n/a | `bool` | `true` | no |
| <a name="input_enable_nat_gateway"></a> [enable\_nat\_gateway](#input\_enable\_nat\_gateway) | (Optional) Should be true if you want to provision NAT Gateways for each of your private networks | `bool` | `true` | no |
| <a name="input_enable_secretmanager_vpc_endpoint"></a> [enable\_secretmanager\_vpc\_endpoint](#input\_enable\_secretmanager\_vpc\_endpoint) | Enable SecretsManager VPC Endpoint if DB is in Private Subnet | `bool` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) Environment e.g Dev, Stg, Prod | `string` | n/a | yes |
| <a name="input_single_nat_gateway"></a> [single\_nat\_gateway](#input\_single\_nat\_gateway) | (Optional) Should be true if you want to provision a single shared NAT Gateway across all of your private networks | `bool` | `true` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | (Required) VPC Cidr | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azs"></a> [azs](#output\_azs) | A list of availability zones specified as argument to this module |
| <a name="output_intra_subnets"></a> [intra\_subnets](#output\_intra\_subnets) | n/a |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | List of IDs of private subnets |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | List of IDs of public subnets |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
