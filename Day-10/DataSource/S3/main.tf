########################################
# Provider
########################################

provider "aws" {
  region = "eu-west-1"
}

########################################
# Data Source: Existing S3 Bucket
########################################

data "aws_s3_bucket" "existing" {
  bucket = "s3-bucket-phoenix-01111"   # your bucket
}

########################################
# Data Source: Your IAM Identity
########################################

data "aws_caller_identity" "me" {}

########################################
# Bucket Policy (Non-Public)
########################################

resource "aws_s3_bucket_policy" "attach" {
  bucket = data.aws_s3_bucket.existing.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${data.aws_caller_identity.me.arn}"
      },
      "Action": "s3:GetObject",
      "Resource": "${data.aws_s3_bucket.existing.arn}/*"
    }
  ]
}
EOF
}
########################################
# Outputs
########################################

output "bucket_arn" {
  value = data.aws_s3_bucket.existing.arn
}

output "bucket_region" {
  value = data.aws_s3_bucket.existing.region
}

output "bucket_domain_name" {
  value = data.aws_s3_bucket.existing.bucket_domain_name
}
