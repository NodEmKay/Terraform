resource "aws_s3_bucket" "this" {
  # We combine the prefix and environment for a consistent name
  bucket = "${var.bucket_name_prefix}-${var.environment}-bucket"

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}