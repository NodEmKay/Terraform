# aws-modules

Reusable Terraform modules for AWS resources.

## Modules
- `ec2/`: EC2 instance module
- `rds/`: RDS instance module
- `s3/`: S3 bucket module
- `vpc/`: VPC and subnet module

Each module contains:
- `main.tf`: Resource definitions
- `variables.tf`: Input variables
- `outputs.tf`: Outputs for cross-stack use

## Usage
Reference modules in your environment configuration:
```
module "ec2" {
  source = "../aws-modules/ec2"
  # ...variables...
}
```

## Purpose
Encapsulate AWS resource logic for reuse and consistency.