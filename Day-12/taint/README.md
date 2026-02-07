# Terraform Taint Practice

This example demonstrates how to use the `terraform taint` command to force recreation of a resource.

## Features
- Creates a simple EC2 instance
- Outputs the instance ID

## Usage Steps
1. Update variables in `terraform.tfvars` as needed.
2. Run `terraform init`.
3. Run `terraform apply` to create the EC2 instance.
4. To force recreation, run:
   ```
   terraform taint aws_instance.taint_demo
   ```
5. Run `terraform apply` again. Terraform will destroy and recreate the tainted instance.
6. To remove taint without recreating, run:
   ```
   terraform untaint aws_instance.taint_demo
   ```

## Security Warning
**This example opens no ports and is for demonstration only. Do NOT use in production.**

## Files
- `main.tf`: EC2 instance resource
- `variables.tf`: Input variables
- `terraform.tfvars`: Variable values
- `outputs.tf`: Outputs instance ID
- `provider.tf`: AWS provider config
