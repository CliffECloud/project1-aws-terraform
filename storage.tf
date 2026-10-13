
# Project 1 - Private S3 application deployment bucket

resource "aws_s3_bucket" "app_artifacts" {
  bucket_prefix = "${var.project_name}-app-artifacts-"

  tags = {
    Name    = "${var.project_name}-app-artifacts"
    Project = var.project_name
  }
}

# Prevent public access
resource "aws_s3_bucket_public_access_block" "app_artifacts" {
  bucket = aws_s3_bucket.app_artifacts.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable version history for deployment packages
resource "aws_s3_bucket_versioning" "app_artifacts" {
  bucket = aws_s3_bucket.app_artifacts.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "app_artifacts" {
  bucket = aws_s3_bucket.app_artifacts.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Ensure the bucket owner owns uploaded objects
resource "aws_s3_bucket_ownership_controls" "app_artifacts" {
  bucket = aws_s3_bucket.app_artifacts.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
