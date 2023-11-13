
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 9.0"

  name = "${var.customer}-alb"

  vpc_id  = var.vpc_id
  subnets = var.subnets

  # For example only
  enable_deletion_protection = var.enable_deletion_protection

  # Security Group
  security_group_ingress_rules = {
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = var.vpc_cidr_block
    }
  }

  listeners = {
    ex_http = {
      port     = 80
      protocol = "HTTP"

      forward = {
        target_group_key = "ec2_tg"
      }
    }
  }

  target_groups = {
    ec2_tg = {
      backend_protocol                  = "HTTP"
      backend_port                      = var.backend_port
      target_type                       = "instance"
      deregistration_delay              = 5
      load_balancing_cross_zone_enabled = true

      create_attachment = false
    }
  }

  tags = var.common_tags
}