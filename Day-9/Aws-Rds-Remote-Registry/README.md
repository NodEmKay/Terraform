# AWS RDS Remote Registry Example

This example uses the official Terraform AWS RDS module to provision a MySQL RDS instance.

## Files
- `main.tf`: Calls the RDS module with configuration for MySQL, networking, monitoring, and tags.
- `provider.tf`: Configures the AWS provider and region.

## Usage
```bash
cd Day-9/Aws-Rds-Remote-Registry
terraform init
terraform plan
terraform apply
```

## Notes
- Update subnet_ids, vpc_security_group_ids, and other variables as needed for your environment.
- The module enables enhanced monitoring and deletion protection by default.
- Credentials and sensitive values should be managed securely (not hardcoded).
- See https://github.com/terraform-aws-modules/terraform-aws-rds for full module documentation.
