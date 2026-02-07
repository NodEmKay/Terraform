# Terraform Nginx Deployment with Multiple Null Resources

This example demonstrates how to deploy an Nginx web server on an AWS EC2 instance using Terraform, with all configuration handled by Terraform and multiple `null_resource` blocks for practice.

## Features
- Deploys an Amazon Linux EC2 instance
- Security group allows SSH (port 22) and HTTP (port 80)
- Installs and starts Nginx using a remote-exec provisioner
- Creates a custom `index.html` using a remote-exec provisioner
- Logs each deployment locally with a timestamp using a local-exec provisioner
- Uses `depends_on` to ensure correct execution order

## Prerequisites
- AWS account and credentials
- AWS CLI installed and configured
- SSH key pair created in AWS (update `key_name` and `private_key` path as needed)
- Terraform installed

## Usage
1. Clone or copy this directory.
2. Update the following in `main.tf`:
   - `key_name` in the `aws_instance` resource to match your AWS key pair
   - `private_key` path in the `remote-exec` provisioners to match your local key file
3. Run `terraform init` to initialize the project.
4. Run `terraform apply` to deploy the infrastructure.
5. After apply:
   - SSH to the instance using its public IP and your key
   - Visit the instance's public IP in your browser to see the custom Nginx page
   - Check `nginx-deploy.log` for local deployment logs

## Code Structure
- `aws_security_group.nginx_sg`: Allows SSH and HTTP access
- `aws_instance.nginx`: Launches the EC2 instance
- `null_resource.install_nginx`: Installs and starts Nginx (remote-exec)
- `null_resource.custom_index`: Creates custom `index.html` (remote-exec, depends_on install_nginx)
- `null_resource.local_log`: Logs deployment locally (local-exec)

## Customization
- Change the Nginx welcome message in the `custom_index` provisioner
- Add more null_resources for additional automation or practice
- Adjust instance type, region, or security group rules as needed

## Important Note

> **⚠️ IMPORTANT:**
> 
> **This code uses `triggers = { always_run = timestamp() }` in all `null_resource` blocks.**
> 
> Every time you run `terraform apply`, the `null_resource`s will be destroyed and recreated, and their provisioners will run again—even if nothing else has changed.
> 
> This is useful for repeated automation and practice, but may not be suitable for production use.
> 
> To run provisioners only when something else changes, remove the `always_run = timestamp()` trigger.

## Clean Up
To destroy all resources:
```
terraform destroy
```

---
This example is ideal for learning and practicing Terraform provisioners, null_resource patterns, and automated server configuration.
