provider "aws" {
  region = "us-east-1"
}

# 1. Create 3 EC2 Instances
resource "aws_instance" "app_server" {
  count         = 3
  ami           = "ami-0c55b159cbfafe1f0" # Update this to a valid AMI in your region
  instance_type = "t2.micro"

  # Ensure volumes are NOT deleted by AWS hardware instantly
  root_block_device {
    delete_on_termination = false
  }

  tags = {
    Name = "Project-Server-${count.index + 1}"
  }

  # SAFETY LOCK: Terraform will refuse to delete these instances
  lifecycle {
    prevent_destroy = true
  }
}

# 2. IAM Role & Policy for Lambda
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
        Action   = ["ec2:DescribeVolumes", "ec2:CreateSnapshot"]
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

# 3. Lambda Function
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "lambda_function.py"
  output_path = "lambda_payload.zip"
}

resource "aws_lambda_function" "snapshot_lambda" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = "ec2-termination-snapshotter"
  role          = aws_iam_role.snapshot_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
}

# 4. EventBridge Trigger (Watching 'shutting-down')
resource "aws_cloudwatch_event_rule" "ec2_shutdown_rule" {
  name        = "watch-ec2-shutting-down"
  event_pattern = jsonencode({
    "source": ["aws.ec2"],
    "detail-type": ["EC2 Instance State-change Notification"],
    "detail": { "state": ["shutting-down"] }
  })
}

resource "aws_cloudwatch_event_target" "sns" {
  rule      = aws_cloudwatch_event_rule.ec2_shutdown_rule.name
  target_id = "TriggerLambda"
  arn       = aws_lambda_function.snapshot_lambda.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.snapshot_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ec2_shutdown_rule.arn
}