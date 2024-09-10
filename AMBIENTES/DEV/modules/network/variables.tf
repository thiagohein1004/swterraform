# variables.tf

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.20.0.0/23"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "vpc-splitwave-dev"
}
