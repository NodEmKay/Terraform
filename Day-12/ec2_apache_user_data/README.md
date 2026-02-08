# EC2 Apache Deployment with user_data

This example demonstrates how to deploy an EC2 instance with Apache installed and a custom `index.html` using the `user_data` mechanism in Terraform. No provisioners or null_resource are used; all configuration is handled at instance launch.

## Files

- `main.tf`: Defines the EC2 instance, security group, and attaches the user_data script.
- `variables.tf`: Input variables for region, AMI, instance type, key, VPC, and environment.
- `outputs.tf`: Outputs for instance ID and public IP.
- `provider.tf`: AWS provider configuration.
- `user_data.sh`: Bash script to install Apache and create a custom index.html at boot.

## How it Works

- The EC2 instance is launched with the `user_data.sh` script, which:
  - Installs Apache (httpd)
  - Enables and starts the service
  - Writes a custom index.html with the instance hostname
- The security group allows HTTP (80) and SSH (22) from anywhere (for demo; restrict in production).
- No manual tainting or triggers are needed; changes to `user_data.sh` will cause the instance to be replaced on the next `terraform apply`.

## Usage

1. **Set variables**: Edit `terraform.tfvars` or provide variables via CLI.
2. **Initialize**:
   ```bash
   terraform init
   ```
3. **Plan**:
   ```bash
   terraform plan -var-file=terraform.tfvars
   ```
4. **Apply**:
   ```bash
   terraform apply -var-file=terraform.tfvars
   ```
5. **Access**:
   - Find the public IP in the outputs or AWS console.
   - Visit `http://<public_ip>` to see the custom page.

## Notes

- **Instance Replacement**: Any change to `user_data.sh` will force a new EC2 instance to be created (existing one is destroyed and replaced).
- **No Audit Log**: Unlike the null_resource example, this pattern does not create audit logs or use provisioners.
- **Best Practice**: Use user_data for simple bootstrapping. For more complex or idempotent configuration, consider configuration management tools or provisioners.

## Clean Up

To destroy the resources:

```bash
terraform destroy -var-file=terraform.tfvars
```
