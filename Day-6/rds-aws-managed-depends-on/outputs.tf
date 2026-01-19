# The connection endpoint (URL) for the database
output "db_instance_endpoint" {
  description = "The connection endpoint for the MariaDB instance"
  value       = aws_db_instance.mariadb_instance.endpoint
}

# The ARN of the secret created by AWS Secrets Manager
output "db_master_password_secret_arn" {
  description = "The ARN of the secret managed by RDS for the master user"
  value       = aws_db_instance.mariadb_instance.master_user_secret[0].secret_arn
}

# The Database Name
output "db_name" {
  description = "The name of the database"
  value       = aws_db_instance.mariadb_instance.db_name
}

# The Security Group ID
output "db_security_group_id" {
  description = "The ID of the security group attached to the RDS instance"
  value       = aws_security_group.mariadb_sg.id
}