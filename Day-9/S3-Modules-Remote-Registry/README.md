# S3 Bucket with Remote Registry Module

This example provisions an S3 bucket using the official Terraform AWS S3 Bucket module.

## Files
- `main.tf`: Calls the S3 bucket module with versioning and object ownership settings.
- `provider.tf`: Configures the AWS provider and region.

## Usage
```bash
cd Day-9/S3-Modules-Remote-Registry
terraform init
terraform plan
terraform apply
```

## Notes
- Update the `bucket` name to be globally unique.
- Versioning is enabled by default.
- See https://github.com/terraform-aws-modules/terraform-aws-s3-bucket for full module documentation.
