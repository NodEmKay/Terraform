# Multiple EC2 Instances with Remote Registry Module

This example provisions multiple EC2 instances using the official Terraform AWS EC2 Instance module.

## Files
- `main.tf`: Uses a for_each loop to create three EC2 instances with unique names.
- `provider.tf`: Configures the AWS provider and region.

## Usage
```bash
cd Day-9/Multiple-EC2-Instance-Remote-Registry
terraform init
terraform plan
terraform apply
```

## Notes
- Update subnet_id, key_name, and tags as needed for your environment.
- Each instance will be named `instance-one`, `instance-two`, and `instance-three`.
- See https://github.com/terraform-aws-modules/terraform-aws-ec2-instance for full module documentation.
