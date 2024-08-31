# variables.tf

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "172.25.0.0/23"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "vpc-splitwave-lab"
}
