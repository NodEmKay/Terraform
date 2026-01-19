provider "aws" {
  region = "us-east-1" # Make sure this is where you want to work
}

# --- AUTOMATIC AMI LOOKUP (Fixes the EC2 Error) ---
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# 1. Create 3 EC2 Instances
resource "aws_instance" "app_server" {
  count         = 3
  ami           = data.aws_ami.amazon_linux_2.id # Uses the lookup result
  instance_type = "t2.micro"

  root_block_device {
    delete_on_termination = false
  }

  tags = {
    Name = "Project-Server-${count.index + 1}"
  }

  lifecycle {
    prevent_destroy = true
  }
}

# 2. S3 Bucket (Fixes the S3 Deletion Error)
resource "aws_s3_bucket" "learning_bucket" {
  bucket        = "my-lambda-learning-bucket2"
  force_destroy = true # <--- This allows deleting even if files exist
}

# 3. IAM Role & Policy for Lambda
resource "aws_iam_role" "snapshot_role" {
  name = "ec2_termination_snapshot_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy" "snapshot_permissions" {
  role = aws_iam_role.snapshot_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["ec2:DescribeVolumes", "ec2:CreateSnapshot", "ec2:DescribeInstances"]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# 4. Lambda Function
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "lambda_function.py"
  output_path = "lambda_payload.zip"
}

resource "aws_lambda_function" "snapshot_lambda" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "ec2-termination-snapshotter"
  role             = aws_iam_role.snapshot_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
}

# 5. EventBridge Trigger
resource "aws_cloudwatch_event_rule" "ec2_shutdown_rule" {
  name = "watch-ec2-shutting-down"
  event_pattern = jsonencode({
    "source": ["aws.ec2"],
    "detail-type": ["EC2 Instance State-change Notification"],
    "detail": { "state": ["shutting-down"] }
  })
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.ec2_shutdown_rule.name
  target_id = "TriggerLambda" # Explicitly naming it fixes the "Empty Result" error
  arn       = aws_lambda_function.snapshot_lambda.arn

  # This ensures the permission exists BEFORE the target tries to connect
  depends_on = [aws_lambda_permission.allow_eventbridge]
}

resource "aws_lambda_permission" "allow_eventbridge" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.snapshot_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ec2_shutdown_rule.arn
}