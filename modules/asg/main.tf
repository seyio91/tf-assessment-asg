data "template_file" "launch_template_userdata" {
  template = file("${path.module}/launch-template/lt.tpl")
}

data "aws_region" "current" {}

locals {
  name   = "${var.customer}-asg"
  region = data.aws_region.current.name

  user_data = base64encode(
    data.template_file.launch_template_userdata.rendered,
  )

  alb_scaling_policy = var.enable_alb_scaling ? {
    request-count-per-target = {
      policy_type               = "TargetTrackingScaling"
      estimated_instance_warmup = 120
      target_tracking_configuration = {
        predefined_metric_specification = {
          predefined_metric_type = "ALBRequestCountPerTarget"
          resource_label         = var.alb_resource_label
        }
        target_value = var.alb_scaling_request_avg
      }
    }
  } : {}
}

module "autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "7.2.0"
  # Autoscaling group
  name            = local.name
  use_name_prefix = false
  instance_name   = var.instance_name

  ignore_desired_capacity_changes = true

  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  default_instance_warmup   = var.default_instance_warmup
  health_check_type         = "EC2"
  vpc_zone_identifier       = var.subnets
  service_linked_role_arn   = aws_iam_service_linked_role.autoscaling.arn

  # Traffic source attachment
  create_traffic_source_attachment = true
  traffic_source_identifier        = var.alb_target_group_arn
  traffic_source_type              = "elbv2"

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay             = 600
      checkpoint_percentages       = [35, 70, 100]
      instance_warmup              = 300
      min_healthy_percentage       = 50
      auto_rollback                = true
      scale_in_protected_instances = "Refresh"
      standby_instances            = "Terminate"
    }
    triggers = ["tag"]
  }

  # Launch template
  launch_template_name        = "${local.name}-lt"
  launch_template_description = "ASG Launch Template"
  update_default_version      = true

  image_id          = var.ami_image_id == null ? data.aws_ami.amazon_linux.id : var.ami_image_id
  instance_type     = var.instance_type
  user_data         = base64encode(local.user_data)
  ebs_optimized     = true
  enable_monitoring = true

  create_iam_instance_profile = true
  iam_role_name               = "${local.name}-role"
  iam_role_path               = "/ec2/"
  iam_role_description        = "ASG ${local.name} IAM role"
  iam_role_tags = {
    CustomIamRole = "Yes"
  }
  iam_role_policies = merge(var.instance_iam_policies, {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  })

  security_groups = [module.asg_sg.security_group_id]

  block_device_mappings = [
    {
      # Root volume
      device_name = "/dev/xvda"
      no_device   = 0
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = 50
        volume_type           = "gp3"
      }
    }
  ]

  placement = {
    availability_zone = "${local.region}b"
  }

  tags = var.common_tags

  # Target scaling policy schedule based on average CPU load
  scaling_policies = merge(local.alb_scaling_policy, {
    avg-cpu-policy = {
      policy_type               = "TargetTrackingScaling"
      estimated_instance_warmup = 1200
      target_tracking_configuration = {
        predefined_metric_specification = {
          predefined_metric_type = "ASGAverageCPUUtilization"
        }
        target_value = var.cpu_autoscaling_average
      }
    }
  })

  depends_on = [time_sleep.wait]
}

################################################################################
# Supporting Resources
################################################################################

module "asg_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "${local.name}-sg"
  description = "ASG ${local.name} SG"
  vpc_id      = var.vpc_id

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = var.alb_sg
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1

  egress_rules = ["all-all"]

  tags = var.common_tags
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }
}

resource "aws_iam_service_linked_role" "autoscaling" {
  aws_service_name = "autoscaling.amazonaws.com"
  description      = "A service linked role for autoscaling"
  custom_suffix    = local.name
}

resource "time_sleep" "wait" {
  create_duration = "10s"
  depends_on      = [aws_iam_service_linked_role.autoscaling]
}
