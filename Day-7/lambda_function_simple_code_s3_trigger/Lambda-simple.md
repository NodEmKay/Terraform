S3 Event Triggered Lambda (Terraform)
This project automates the creation of an Event-Driven Architecture on AWS. It sets up an S3 bucket that "talks" to a Lambda function. Every time a file is uploaded or deleted, the Lambda function is triggered to log the activity.

#Overview
The infrastructure consists of three main components working in harmony:

S3 Bucket: The storage layer where files are uploaded.

AWS Lambda: The compute layer that runs a Python script whenever an event occurs.

IAM Roles: The security layer that grants the necessary permissions for S3 to trigger Lambda and for Lambda to write logs.

#The Architecture
Event Source: A user or application uploads a file to my-lambda-learning-bucket2.

Notification: S3 detects the activity and sends a JSON payload to Lambda.

Processing: Lambda executes the Python code (lambda_handler) to process the event metadata.

Observability: The output is automatically recorded in Amazon CloudWatch Logs for monitoring.

#Project Structure
Plaintext

.
├── main.tf              # Terraform configuration (S3, Lambda, IAM)
├── lambda_function.py   # Python code that handles the S3 event
└── README.md            # Project documentation
#Prerequisites
Terraform CLI installed on your local machine.

AWS CLI configured with valid credentials.

Python 3.x (for the Lambda runtime).

#Deployment Steps
Initialize: Prepare the working directory and download providers.

Bash

terraform init
Plan: Preview the changes Terraform will make to your AWS account.

Bash

terraform plan
Apply: Deploy the resources.

Bash

terraform apply

#How to Test
Log into your AWS Console and navigate to S3.

Upload a file to my-lambda-learning-bucket2.

Navigate to CloudWatch Logs.

Find the Log Group /aws/lambda/s3-activity-logger to see the details of your upload.
