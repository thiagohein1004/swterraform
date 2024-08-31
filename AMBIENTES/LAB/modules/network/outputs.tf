# outputs.tf

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = [aws_subnet.public_aza.id, aws_subnet.public_azb.id]
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = [aws_subnet.private_aza.id, aws_subnet.private_azb.id]
}

output "db_subnet_ids" {
  description = "IDs of DB subnets"
  value       = [aws_subnet.db_aza.id, aws_subnet.db_azb.id]
}

output "igw_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.this.id
}

output "nat_gateway_ids" {
  description = "IDs of NAT Gateways"
  value       = [aws_nat_gateway.nat_aza.id, aws_nat_gateway.nat_azb.id]
}

output "ecs_security_group_id" {
  description = "ID of the ECS Security Group"
  value       = aws_security_group.ecs.id
}

output "alb_security_group_id" {
  description = "ID of the ALB Security Group"
  value       = aws_security_group.alb.id
}

output "rds_security_group_id" {
  description = "ID of the RDS Security Group"
  value       = aws_security_group.rds.id
}

output "amazonmq_security_group_id" {
  description = "ID of the AmazonMQ Security Group"
  value       = aws_security_group.amazonmq.id
}
