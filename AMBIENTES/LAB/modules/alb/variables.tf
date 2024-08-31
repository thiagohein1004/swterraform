# variables.tf

variable "vpc_id" {
  description = "VPC ID for the ALB and Target Group"
  type        = string  
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ALB"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for the ALB"
  type        = list(string)
}

variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
  default     = "alb-splitwave-lab"
}

variable "target_group_name" {
  description = "Name of the Target Group"
  type        = string
  default     = "tg-splitwave-lab"
}

variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate for HTTPS listener"
  type        = string
}
