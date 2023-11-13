variable "customer" {
  description = "Name to attach to all Resources"
  type        = string
}

variable "instance_name" {
  description = "Name of EC2 Instance"
  type        = string
}

variable "instance_type" {
  description = "The type of the instance."
  default     = "t3.micro"
}

variable "vpc_id" {
  description = "VPC_ID to deploy ASG Security Group"
  type        = string
}

variable "ami_image_id" {
  description = "The AMI from which to launch the instance, Default to Amazon Linux"
  default     = null
}

variable "min_size" {
  description = "The minimum size of the autoscaling group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "The Maximum size of the autoscaling group"
  type        = number
  default     = 3
}

variable "desired_capacity" {
  description = " The number of Amazon EC2 instances that should be running in the autoscaling group"
  default     = 1
  type        = number
}

variable "default_instance_warmup" {
  description = "Amount of time, in seconds, until a newly launched instance can contribute to the Amazon CloudWatch metrics."
  default     = 300
  type        = number
}

variable "wait_for_capacity_timeout" {
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out."
  default     = 0
  type        = number
}

variable "subnets" {
  description = "A list of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside."
  type        = list(string)
}

variable "alb_target_group_arn" {
  description = "Identifies the traffic source. This will be the Amazon Resource Name (ARN) for a target group."
  type        = string
}

variable "instance_iam_policies" {
  description = "Additional IAM Roles to Attach to instance"
  type        = map(string)
  default     = {}
}

variable "common_tags" {
  description = "Tags to Add to Resources"
  type        = map(any)
}

variable "cpu_autoscaling_average" {
  description = "Percentage of target CPU utilization for autoscaling"
  default     = 60.0
  type        = number
}

variable "enable_alb_scaling" {
  description = "Toggle to enable Autoscaling on ALB Requests Count"
  default     = false
  type        = bool
}

variable "alb_scaling_request_avg" {
  description = "Target ALB Request Count for Autoscaling"
  default     = 500
  type        = number
}

variable "alb_resource_label" {
  description = "Resource Cloudwatch Metric Label for Target ALB"
  default     = ""
  type        = string
}

variable "alb_sg" {
  description = "Security Group for ALB"
  type        = string
}
