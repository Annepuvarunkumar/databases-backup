#RDS Database
resource "aws_db_instance" "my_database" {
  identifier               = "my-database"
  allocated_storage        = 20
  instance_class           = "db.t3.micro"  # Choose a class suitable for testing
  engine                   = var.db_engine
  engine_version           = var.db_engine_version
  username                 = var.db_username
  password                 = var.db_password
  publicly_accessible      = true
  backup_retention_period  = 7  # Retain automated backups for 7 days
  skip_final_snapshot      = true  # Retain data when deleting
  storage_encrypted        = true  # Enable encryption
}

# Backup Vault
resource "aws_backup_vault" "backup_vault" {
  name = var.backup_vault_name
}

# Backup Plan
resource "aws_backup_plan" "backup_plan" {
  name = var.backup_plan_name

  rule {
    rule_name         = "rds-backup-rule"
    target_vault_name = aws_backup_vault.backup_vault.name
    schedule          = var.schedule

    lifecycle {
      delete_after = var.retention_days
    }
  }
}

# IAM Role for AWS Backup
resource "aws_iam_role" "backup_role" {
  name = "aws-backup-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "backup.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach Policy to IAM Role
resource "aws_iam_policy_attachment" "backup_role_policy_attachment" {
  name       = "backup-role-policy"
  roles      = [aws_iam_role.backup_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

#Backup Selection for RDS Database
resource "aws_backup_selection" "rds_backup_selection" {
  name           = "rds-backup-selection"
  iam_role_arn   = aws_iam_role.backup_role.arn
  plan_id        = aws_backup_plan.backup_plan.id

  resources = [aws_db_instance.my_database.arn]
}

