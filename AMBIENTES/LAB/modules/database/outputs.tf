# outputs.tf

output "db_cluster_endpoint" {
  description = "The endpoint of the RDS cluster"
  value       = aws_rds_cluster.this.endpoint
}

output "db_reader_endpoint" {
  description = "The reader endpoint of the RDS cluster"
  value       = aws_rds_cluster.this.reader_endpoint
}

output "kms_key_id" {
  description = "KMS Key ID for RDS encryption"
  value       = aws_kms_key.rds.id
}

output "secret_arn" {
  description = "The ARN of the secret in Secrets Manager"
  value       = aws_secretsmanager_secret.db_secret.arn
}
