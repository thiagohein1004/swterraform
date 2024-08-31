# variables.tf

variable "secret_name" {
  description = "Name of the secret in AWS Secrets Manager"
  type        = string
  default     = "db-splitwave-asm-lab"
}

variable "db_identifier" {
  description = "Identifier for the RDS database"
  type        = string
  default     = "db-lab-splitwave"
}

variable "engine" {
  description = "Database engine type"
  type        = string
  default     = "aurora-postgresql"
}

variable "db_version" {
  description = "Version of the database engine"
  type        = string
  default     = "14.9"
}

variable "instance_class" {
  description = "Instance class for the RDS instances"
  type        = string
  default     = "db.r5.large"
}

variable "master_username" {
  description = "Master username for the RDS database"
  type        = string
  default     = "admin_api"
}

variable "db_subnet_ids" {
  description = "List of subnet IDs for the RDS subnet group"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for the RDS cluster"
  type        = list(string)
}

variable "instance_count" {
  description = "Number of RDS instances in the cluster"
  type        = number
  default     = 1
}
