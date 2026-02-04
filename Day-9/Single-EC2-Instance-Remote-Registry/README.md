# Single EC2 Instance with Remote Registry Module

This example provisions a single EC2 instance using the official Terraform AWS EC2 Instance module.

## Files
- `main.tf`: Calls the EC2 instance module with basic configuration.
- `provider.tf`: Configures the AWS provider and region.

## Usage
```bash
cd Day-9/Single-EC2-Instance-Remote-Registry
terraform init
terraform plan
terraform apply
```

## Notes
- Update subnet_id, key_name, and tags as needed for your environment.
- The instance will be named `single-instance`.
- See https://github.com/terraform-aws-modules/terraform-aws-ec2-instance for full module documentation.
