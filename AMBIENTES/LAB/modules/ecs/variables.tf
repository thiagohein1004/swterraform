# variables.tf

variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "splitwave-lab-cluster"
}

variable "task_family" {
  description = "Family of the ECS task definition"
  type        = string
  default     = "splitwave-lab-task"
}

variable "container_name" {
  description = "Name of the ECS container"
  type        = string
  default     = "splitwave-lab-container"
}

variable "container_image" {
  description = "URI of the container image in ECR"
  type        = string
  default     = "615299742468.dkr.ecr.us-east-1.amazonaws.com/splitwave-lab:latest"
}

variable "task_role" {
  description = "ARN of the task role for ECS task"
  type        = string
}

variable "task_execution_role" {
  description = "ARN of the task execution role for ECS task"
  type        = string
}

variable "log_group" {
  description = "CloudWatch Logs log group for ECS task logs"
  type        = string
  default     = "splitwave-lab-container-log"
}

variable "log_stream_prefix" {
  description = "Prefix for log streams of the ECS task logs in CloudWatch"
  type        = string
  default     = "splitwave-lab-container"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ECS service"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for the ECS service"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN of the target group to attach to the ECS service"
  type        = string
}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string
  default     = "splitwave-lab-service"
}

variable "desired_count" {
  description = "Desired number of ECS tasks"
  type        = number
  default     = 1
}
