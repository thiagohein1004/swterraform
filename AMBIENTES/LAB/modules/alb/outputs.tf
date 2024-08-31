# outputs.tf

output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = aws_lb.alb_splitwave_lab.arn
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.alb_splitwave_lab.dns_name
}

output "target_group_arn" {
  description = "The ARN of the Target Group"
  value       = aws_lb_target_group.tg_splitwave_lab.arn
}
