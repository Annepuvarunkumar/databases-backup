#RDS Database
resource "aws_db_instance" "my_database" {
  identifier               = "my-database"
  allocated_storage        = 20
  instance_class           = "db.t3.micro"  # Choose a class suitable for testing
  engine                   = var.db_engine
  engine_version           = var.db_engine_version
  username                 = var.db_username
  password                 = var.db_password
  publicly_accessible      = true  # Set to true if testing outside VPC
  backup_retention_period  = 7  # Retain automated backups for 7 days
  skip_final_snapshot      = false  # Retain data when deleting
  storage_encrypted        = true  # Enable encryption
}
