output "rds_instance_arn" {
  value = aws_db_instance.my_database.arn
}

output "rds_database_arn" {
  description = "The ARN of the RDS database"
  value       = aws_db_instance.my_database.arn
}

output "backup_vault_name" {
  description = "The name of the backup vault"
  value       = aws_backup_vault.backup_vault.name
}

output "backup_plan_id" {
  description = "The ID of the backup plan"
  value       = aws_backup_plan.backup_plan.id
}

output "iam_role_arn" {
  description = "The ARN of the IAM role used for backups"
  value       = aws_iam_role.backup_role.arn
}
