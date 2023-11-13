locals {
  config              = yamldecode(file("./config.yaml"))

  region              = try(local.config["region"], "eu-west-1")
  customer            = local.config["customer"]
  vpc_cidr_block      = try(local.config["vpc_cidr"], "10.0.0.0/16")
  
  common_tags         = try(local.config["tags"], {})

  instance_name       = try(local.config["ec2_instance"]["name"], local.customer)
  backend_port        = try(local.config["ec2_instance"]["port"], 80)
  instance_type       = try(local.config["ec2_instance"]["type"], "t3.small")
  cpu_average         = try(local.config["ec2_instance"]["scaling_cpu"], 60.0)
  min_size            = try(local.config["ec2_instance"]["min_size"], 1)
  max_size            = try(local.config["ec2_instance"]["max_size"], 3)
  desired_size        = try(local.config["ec2_instance"]["desired_size"], 1)

  alb_scaling_enabled = try(local.config["alb_scaling"]["enabled"], false)
  alb_request_avg     = try(local.config["alb_scaling"]["request_count"], 500)
}
