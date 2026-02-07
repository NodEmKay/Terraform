resource "null_resource" "s3_sync" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "aws s3 sync ./project-code s3://my-bucket-s3-10001 && echo Sync at %DATE% %TIME% >> s3-sync.log"
  }
}

# Instructions:
# 1. Replace 'your-bucket-name' with your actual S3 bucket name.
# 2. Ensure AWS CLI is installed and configured with proper credentials.
