# EC2 Apache Demo with Tainted index.html

This example creates an EC2 Linux instance, installs Apache, and uploads a styled `index.html` file. The `index.html` deployment is managed by a `null_resource` that is automatically tainted and redeployed whenever the file changes. All activities are logged for auditing.

## Features
- Launches an EC2 instance using the `key101.pem` key pair
- Installs Apache (httpd or apache2)
- Opens port 80 for HTTP and 22 for SSH
- Uploads and deploys a custom `index.html` (Costco-style)
- Only the `index.html` deployment is tainted/redeployed when the file changes
- Outputs the public IP for browser access
- Logs all index.html deployments and every Terraform apply in audit files

## Prerequisites
- AWS account and credentials configured
- Existing EC2 Key Pair named `key101` and the private key file at `C:/Users/muthu/.ssh/key101.pem`
- Terraform installed

## Usage Steps
1. **Clone or copy this directory.**
2. **Update variables in `terraform.tfvars` if needed:**
   - `aws_region`, `ami`, `instance_type`, `key_name`, `private_key_path`
3. **Place your custom `index.html` in this folder.**
   - The provided file is styled like Costco for demo purposes.
4. **Run Terraform initialization:**
   ```
   terraform init
   ```
5. **Apply the configuration:**
   ```
   terraform apply
   ```
   - Review the plan and type `yes` to confirm.
6. **Access your web server:**
   - Find the public IP in the Terraform output or AWS console.
   - Visit `http://<web_public_ip>` in your browser to see the page.
7. **Update and redeploy `index.html`:**
   - Edit `index.html` and save.
   - Run `terraform apply` again. Only the deployment block will rerun, updating the file on the server.
8. **Audit logs:**
   - `index_deploy_audit.log`: Shows each deployment of `index.html` with hash and timestamp.
   - `directory_activity_audit.log`: Shows every Terraform apply run with timestamp.

## How it works
- The `null_resource.deploy_index` uses a trigger based on the hash of `index.html`.
- When the file changes, the resource is tainted and the provisioners rerun, redeploying the new file.
- The `null_resource.directory_audit` logs every apply for auditing.

## Security Warning
**This example opens HTTP and SSH to the world for demonstration. Do NOT use in production without restricting access.**

## Files
- `main.tf`: EC2, security group, and null_resources for index.html and auditing
- `variables.tf`: Input variables
- `terraform.tfvars`: Variable values
- `outputs.tf`: Outputs public IP
- `provider.tf`: AWS provider config
- `index.html`: Your custom web page
- `index_deploy_audit.log`: Audit log for index.html deployments
- `directory_activity_audit.log`: Audit log for all Terraform apply runs
