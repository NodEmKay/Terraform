# S3 Event Triggered Lambda (Terraform)

This project automates the creation of an **Event-Driven Architecture** on AWS. It sets up an S3 bucket that "talks" to a Lambda function. Every time a file is uploaded or deleted, the Lambda function is triggered to log the activity.

## Overview

The infrastructure consists of three main components working in harmony:

1. **S3 Bucket:** The storage layer where files are uploaded.
2. **AWS Lambda:** The compute layer that runs a Python script whenever an event occurs.
3. **IAM Roles:** The security layer that grants the necessary permissions for S3 to trigger Lambda and for Lambda to write logs.

## The Architecture

1. **Event Source:** A user or application uploads a file to `my-lambda-learning-bucket2`.
2. **Notification:** S3 detects the activity and sends a JSON payload to Lambda.
3. **Processing:** Lambda executes the Python code (`lambda_handler`) to process the event metadata.
4. **Observability:** The output is automatically recorded in **Amazon CloudWatch Logs** for monitoring.

## Project Structure

```text
.
├── main.tf              # Terraform configuration (S3, Lambda, IAM)
├── lambda_function.py   # Python code that handles the S3 event
└── lambda-simple-function.md            # Project documentation

```

## Prerequisites

* **Terraform CLI** installed on your local machine.
* **AWS CLI** configured with valid credentials.
* **Python 3.x** (for the Lambda runtime).

## Deployment Steps

1. **Initialize:** Prepare the working directory and download providers.
```bash
terraform init

```


2. **Plan:** Preview the changes Terraform will make to your AWS account.
```bash
terraform plan

```


3. **Apply:** Deploy the resources.
```bash
terraform apply

```



## How to Test

1. Log into your **AWS Console** and navigate to S3.
2. Upload a file to `my-lambda-learning-bucket2`.
3. Navigate to **CloudWatch Logs**.
4. Find the Log Group `/aws/lambda/s3-activity-logger` to see the details of your upload.

