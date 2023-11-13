
output "target_groups_arn" {
  description = "Map of target groups created and their attributes (ARN)"
  value       = module.alb.target_groups["ec2_tg"].arn
}

output "target_groups_arn_suffix" {
  description = "Map of target groups created and their attributes (ARN Suffix)"
  value       = module.alb.target_groups["ec2_tg"].arn_suffix
}

output "arn_suffix" {
  description = "ARN suffix of our load balancer - can be used with CloudWatch"
  value       = module.alb.arn_suffix
}

output "security_group_id" {
  description = "ID of the security group Generated"
  value       = module.alb.security_group_id
}

output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.alb.dns_name
}
