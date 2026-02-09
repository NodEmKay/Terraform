terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 7.0"
    }
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "workspace-demo-bucket-${terraform.workspace}"
  tags = {
    Environment = terraform.workspace
    ManagedBy   = "Terraform"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.example.bucket
}
