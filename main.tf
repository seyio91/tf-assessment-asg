provider "aws" {
  region  = local.region
  default_tags {
    tags = {
      Owner = "Terraform"
    }
  }
}

module "vpc" {
  source      = "./modules/vpc"
  customer    = local.customer
  vpc_cidr    = local.vpc_cidr_block
  common_tags = local.common_tags
}

module "alb" {
  source         = "./modules/alb"
  customer       = local.customer
  subnets        = module.vpc.public_subnets
  vpc_id         = module.vpc.vpc_id
  vpc_cidr_block = module.vpc.vpc_cidr_block
  backend_port   = local.backend_port
  common_tags    = local.common_tags
}


module "asg" {
  source                  = "./modules/asg"
  customer                = local.customer
  instance_name           = local.instance_name
  instance_type           = local.instance_type
  vpc_id                  = module.vpc.vpc_id
  min_size                = local.min_size
  max_size                = local.max_size
  desired_capacity        = local.desired_size
  subnets                 = module.vpc.private_subnets
  alb_target_group_arn    = module.alb.target_groups_arn
  alb_sg                  = module.alb.security_group_id
  cpu_autoscaling_average = local.cpu_average
  enable_alb_scaling      = local.alb_scaling_enabled
  alb_scaling_request_avg = local.alb_request_avg
  alb_resource_label      = "${module.alb.arn_suffix}/${module.alb.target_groups_arn_suffix}"
  common_tags             = local.common_tags
  depends_on = [
    module.vpc,
    module.alb
  ]
}

output "alb_dns_name" {
  description = "Access LoadBalancer using the DNS"
  value       = module.alb.lb_dns_name
}
