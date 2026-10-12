
# ==========================================
# PROJECT 1 - EC2 IAM ROLE
# ==========================================

resource "aws_iam_role" "ec2" {
  name                 = "${var.project_name}-ec2-role"
  description          = "Allows Project 1 EC2 instances to use Systems Manager and approved AWS services"
  max_session_duration = 3600

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

# ==========================================
# SYSTEMS MANAGER - EC2 MANAGEMENT
# ==========================================

resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# ==========================================
# AWS ACCOUNT INFORMATION
# ==========================================

data "aws_caller_identity" "current" {}

# ==========================================
# DATABASE PASSWORD PERMISSION
# Existing permission - preserved
# ==========================================

resource "aws_iam_role_policy" "read_db_password" {
  name = "${var.project_name}-read-db-password"
  role = aws_iam_role.ec2.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "ReadProject1DatabasePassword"
        Effect = "Allow"

        Action = [
          "ssm:GetParameter"
        ]

        Resource = "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.current.account_id}:parameter/project1/database/password"
      }
    ]
  })
}

# ==========================================
# DATABASE CONFIGURATION PERMISSIONS
# New permissions - host, port, name, username
# ==========================================

resource "aws_iam_role_policy" "read_db_config" {
  name = "${var.project_name}-read-db-config"
  role = aws_iam_role.ec2.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "ReadProject1DatabaseConfiguration"
        Effect = "Allow"

        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters"
        ]

        Resource = [
          "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.current.account_id}:parameter/${var.project_name}/database/host",
          "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.current.account_id}:parameter/${var.project_name}/database/port",
          "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.current.account_id}:parameter/${var.project_name}/database/name",
          "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.current.account_id}:parameter/${var.project_name}/database/username"
        ]
      }
    ]
  })
}

# ==========================================
# EC2 INSTANCE PROFILE
# ==========================================

resource "aws_iam_instance_profile" "ec2" {
  name = "${var.project_name}-ec2-role"
  role = aws_iam_role.ec2.name
}
