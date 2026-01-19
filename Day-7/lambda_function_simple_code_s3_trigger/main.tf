provider "aws" {
  region = "us-east-1" # Change to your preferred region
}

# 1. Create the S3 Bucket
resource "aws_s3_bucket" "learning_bucket" {
  bucket = "my-lambda-learning-bucket2"
}

# 2. Create IAM Role for Lambda
resource "aws_iam_role" "iam_for_lambda" {
  name = "my_lambda_s3_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# 3. Attach Basic Execution Policy (Allows logging to CloudWatch)
resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# 4. Zip the Python code
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "lambda_function.py"
  output_path = "lambda_function_payload.zip"
}

# 5. Create the Lambda Function
resource "aws_lambda_function" "test_lambda" {
  filename      = "lambda_function_payload.zip"
  function_name = "s3-activity-logger"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
}

# 6. GIVE S3 PERMISSION TO CALL LAMBDA (Crucial Step)
resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.test_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.learning_bucket.arn
}

# 7. Create the Trigger (S3 Event Notification)
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.learning_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.test_lambda.arn
    events              = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"] 
    # "s3:ObjectCreated:*" covers all uploads, copies, etc.
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}