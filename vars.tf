# Database Variables
variable "db_engine" {
  description = "The database engine for the RDS instance"
  default     = "mariadb"
}

variable "db_engine_version" {
  description = "The version of the database engine"
  default     = "10.4.29"
}

variable "db_username" {
  description = "The master username for the RDS database"
  default     = "admin"
}

variable "db_password" {
  description = "The master password for the RDS database"
}

# Backup Variables
variable "backup_vault_name" {
  description = "Name of the AWS Backup vault"
  default     = "rds-backup-vault"
}

variable "backup_plan_name" {
  description = "Name of the AWS Backup plan"
  default     = "rds-backup-plan"
}

variable "retention_days" {
  description = "Number of days to retain the backups"
  default     = 7
}

variable "schedule" {
  description = "CRON schedule for the backup plan (UTC)"
  default     = "cron(0 12 * * ? *)"  # Daily at 12:00 PM UTC
}

