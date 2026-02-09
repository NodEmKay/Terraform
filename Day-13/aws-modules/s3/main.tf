# S3 Module
resource "aws_s3_bucket" "this" {
  bucket = "${var.bucket_name}-${var.tags["Environment"]}"
  tags   = var.tags
}
