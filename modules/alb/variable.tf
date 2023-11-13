variable "customer" {
  description = "Name to attach to all Resources"
  type        = string
}

variable "subnets" {
  description = "Public Subnet to Deploy ALB Resource"
  type        = list(string)
}
variable "vpc_id" {
  description = "ID of VPC for Deploying Resources"
  type        = string
}
variable "vpc_cidr_block" {
  description = "CIDR Block to Allow in Security Group"
  type        = string
}
variable "common_tags" {
  description = "Tags to Add to Resources"
  type        = map(any)
}

variable "enable_deletion_protection" {
  description = "Enable to Prevent Deletion of ALB using API"
  default     = false
  type        = bool
}

variable "backend_port" {
  description = "Backend Port For ALB to Communicate with the Application"
  type        = number
  default     = 80
}
