# Terraform AWS Infrastructure Learning Repository

This codebase is a progressive Terraform tutorial for AWS infrastructure, organized by days from basic EC2 setup to advanced patterns like modules and serverless.

## Architecture Overview

- **Modular Structure**: Each `Day-N/` contains standalone Terraform configurations demonstrating specific AWS services
- **Environment Management**: Uses Terraform workspaces (`dev`, `prod`, `test`) with environment-specific `.tfvars` files
- **Remote State**: S3 backend with DynamoDB locking for state management across environments
- **Resource Dependencies**: Relies on implicit dependencies via resource references rather than explicit `depends_on`

## Key File Structure

```
Day-N/
├── main.tf           # Primary resource definitions
├── variables.tf      # Input variable declarations
├── outputs.tf        # Output value definitions
├── provider.tf       # AWS provider configuration
├── backend.tf        # Remote state backend config
└── terraform.tfvars  # Default variable values
```

## Critical Workflows

### Environment-Specific Deployment
```bash
terraform workspace select dev
terraform init
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
```

### Module Usage
- Modules stored in `./modules/` subdirectories
- Reference with relative paths: `source = "./modules/simple_s3"`
- Use `terraform get` to download external modules

### State Management
- S3 bucket for state storage: `bucket = "node-s3-bucket0011"`
- DynamoDB table for locking: `dynamodb_table = "use_dydb_to_monitor_tasks_and_lock_tf_state_when_required"`
- Always run `terraform init` after backend changes

## Project Conventions

### Resource Naming
- Bucket names: `"${var.bucket_name_prefix}-${var.environment}-bucket"`
- Tags: Include `Environment` and `ManagedBy = "Terraform"`

### Provider Configuration
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.0,<=6.0"
    }
  }
}
```

### Lambda Functions
- Python code in separate `.py` files alongside `main.tf`
- Use `data "archive_file"` to zip code before deployment
- Handler format: `"lambda_function.lambda_handler"`

### Security Groups
- Allow SSH (port 22) from `0.0.0.0/0` for bastion hosts
- Restrict private instances to VPC-internal access

## Common Patterns

- **Implicit Dependencies**: EC2 instances reference VPC/subnet/security group IDs directly
- **Variable Files**: Environment-specific overrides in `dev.tfvars`, `prod.tfvars`, etc.
- **Outputs**: Expose resource ARNs, IDs, and endpoints for cross-configuration usage
- **Lifecycle Management**: Use `prevent_destroy = true` for production resources (commented in examples)

## Integration Points

- **AWS Services**: EC2, VPC, S3, RDS, Lambda, DynamoDB
- **IAM**: Roles for Lambda with `sts:AssumeRole` policies
- **Triggers**: S3 bucket notifications for Lambda functions
- **Secrets**: RDS credentials via AWS Secrets Manager or self-managed

Reference examples in `Day-4/remote-state/`, `Day-7/lambda_function_simple_code_s3_trigger/`, and `Day-8/terraform-practice/modules/` for implementation patterns.