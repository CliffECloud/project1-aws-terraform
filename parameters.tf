# ==========================================
# PROJECT 1 - DATABASE CONFIGURATION
# AWS SYSTEMS MANAGER PARAMETER STORE
# ==========================================

# Database hostname
resource "aws_ssm_parameter" "db_host" {
  name        = "/${var.project_name}/database/host"
  description = "PostgreSQL RDS hostname for Project 1"
  type        = "String"
  value       = aws_db_instance.postgres.address

  tags = {
    Name = "${var.project_name}-db-host"
  }
}

# Database port
resource "aws_ssm_parameter" "db_port" {
  name        = "/${var.project_name}/database/port"
  description = "PostgreSQL database port"
  type        = "String"
  value       = tostring(var.db_port)

  tags = {
    Name = "${var.project_name}-db-port"
  }
}

# Database name
resource "aws_ssm_parameter" "db_name" {
  name        = "/${var.project_name}/database/name"
  description = "PostgreSQL database name"
  type        = "String"
  value       = aws_db_instance.postgres.db_name

  tags = {
    Name = "${var.project_name}-db-name"
  }
}

# Database username
resource "aws_ssm_parameter" "db_username" {
  name        = "/${var.project_name}/database/username"
  description = "PostgreSQL database username"
  type        = "String"
  value       = aws_db_instance.postgres.username

  tags = {
    Name = "${var.project_name}-db-username"
  }
}

