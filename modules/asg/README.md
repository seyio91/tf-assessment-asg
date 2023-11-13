## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.13.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.13.1 |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_asg_sg"></a> [asg\_sg](#module\_asg\_sg) | terraform-aws-modules/security-group/aws | ~> 5.0 |
| <a name="module_autoscaling"></a> [autoscaling](#module\_autoscaling) | terraform-aws-modules/autoscaling/aws | 7.2.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_service_linked_role.autoscaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_linked_role) | resource |
| [aws_ami.amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [template_file.launch_template_userdata](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_resource_label"></a> [alb\_resource\_label](#input\_alb\_resource\_label) | Resource Cloudwatch Metric Label for Target ALB | `string` | `""` | no |
| <a name="input_alb_scaling_request_avg"></a> [alb\_scaling\_request\_avg](#input\_alb\_scaling\_request\_avg) | Target ALB Request Count for Autoscaling | `number` | `500` | no |
| <a name="input_alb_sg"></a> [alb\_sg](#input\_alb\_sg) | Security Group for ALB | `string` | n/a | yes |
| <a name="input_alb_target_group_arn"></a> [alb\_target\_group\_arn](#input\_alb\_target\_group\_arn) | Identifies the traffic source. This will be the Amazon Resource Name (ARN) for a target group. | `string` | n/a | yes |
| <a name="input_ami_image_id"></a> [ami\_image\_id](#input\_ami\_image\_id) | The AMI from which to launch the instance, Default to Amazon Linux | `any` | `null` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Tags to Add to Resources | `map(any)` | n/a | yes |
| <a name="input_cpu_autoscaling_average"></a> [cpu\_autoscaling\_average](#input\_cpu\_autoscaling\_average) | Percentage of target CPU utilization for autoscaling | `number` | `60` | no |
| <a name="input_customer"></a> [customer](#input\_customer) | Name to attach to all Resources | `string` | n/a | yes |
| <a name="input_default_instance_warmup"></a> [default\_instance\_warmup](#input\_default\_instance\_warmup) | Amount of time, in seconds, until a newly launched instance can contribute to the Amazon CloudWatch metrics. | `number` | `300` | no |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the autoscaling group | `number` | `1` | no |
| <a name="input_enable_alb_scaling"></a> [enable\_alb\_scaling](#input\_enable\_alb\_scaling) | Toggle to enable Autoscaling on ALB Requests Count | `bool` | `false` | no |
| <a name="input_instance_iam_policies"></a> [instance\_iam\_policies](#input\_instance\_iam\_policies) | Additional IAM Roles to Attach to instance | `map(string)` | `{}` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name of EC2 Instance | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of the instance. | `string` | `"t3.micro"` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | The Maximum size of the autoscaling group | `number` | `3` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | The minimum size of the autoscaling group | `number` | `1` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A list of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside. | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC\_ID to deploy ASG Security Group | `string` | n/a | yes |
| <a name="input_wait_for_capacity_timeout"></a> [wait\_for\_capacity\_timeout](#input\_wait\_for\_capacity\_timeout) | A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. | `number` | `0` | no |

## Outputs

No outputs.
