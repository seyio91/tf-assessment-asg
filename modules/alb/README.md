## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.13.1 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | terraform-aws-modules/alb/aws | ~> 9.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend_port"></a> [backend\_port](#input\_backend\_port) | Backend Port For ALB to Communicate with the Application | `number` | `80` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Tags to Add to Resources | `map(any)` | n/a | yes |
| <a name="input_customer"></a> [customer](#input\_customer) | Name to attach to all Resources | `string` | n/a | yes |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | Enable to Prevent Deletion of ALB using API | `bool` | `false` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Public Subnet to Deploy ALB Resource | `list(string)` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR Block to Allow in Security Group | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of VPC for Deploying Resources | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn_suffix"></a> [arn\_suffix](#output\_arn\_suffix) | ARN suffix of our load balancer - can be used with CloudWatch |
| <a name="output_lb_dns_name"></a> [lb\_dns\_name](#output\_lb\_dns\_name) | The DNS name of the load balancer |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID of the security group Generated |
| <a name="output_target_groups_arn"></a> [target\_groups\_arn](#output\_target\_groups\_arn) | Map of target groups created and their attributes (ARN) |
| <a name="output_target_groups_arn_suffix"></a> [target\_groups\_arn\_suffix](#output\_target\_groups\_arn\_suffix) | Map of target groups created and their attributes (ARN Suffix) |
