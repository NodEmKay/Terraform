provider "aws" {
  region = "us-east-1" 
}

# 1. IAM Role for Lambda
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

# 2. Permissions: Snapshot + CloudWatch Logs
resource "aws_iam_policy" "snapshot_policy" {
  name = "EC2SnapshotPermissions"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:DescribeVolumes",
          "ec2:CreateSnapshot",
          "ec2:DescribeInstances"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.snapshot_role.name
  policy_arn = aws_iam_policy.snapshot_policy.arn
}

# 3. Zip the code (assumes lambda_function.py is in the same folder)
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "lambda_function.py"
  output_path = "snapshot_lambda_payload.zip"
}

# 4. The Lambda Function
resource "aws_lambda_function" "snapshot_lambda" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = "ec2-termination-snapshotter"
  role          = aws_iam_role.snapshot_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
}

# 5. EventBridge Rule: Watch for 'shutting-down'
resource "aws_cloudwatch_event_rule" "ec2_shutting_down_rule" {
  name        = "watch-ec2-shutting-down"
  description = "Capture EC2 instances as they begin to shut down"

  event_pattern = jsonencode({
    "source": ["aws.ec2"],
    "detail-type": ["EC2 Instance State-change Notification"],
    "detail": {
      "state": ["shutting-down"]
    }
  })
}

# 6. Target: Point the Rule to the Lambda
resource "aws_cloudwatch_event_target" "target_lambda" {
  rule      = aws_cloudwatch_event_rule.ec2_shutting_down_rule.name
  target_id = "TriggerSnapshotLambda"
  arn       = aws_lambda_function.snapshot_lambda.arn
}

# 7. Permission: Allow EventBridge to talk to Lambda
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.snapshot_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ec2_shutting_down_rule.arn
}