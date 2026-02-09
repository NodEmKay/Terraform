# Simple Terraform Workspace Practice

This example demonstrates how to use Terraform workspaces to create environment-specific resources on AWS.

## What It Does
- Creates an S3 bucket with the workspace name in the bucket name (e.g., `workspace-demo-bucket-dev`, `workspace-demo-bucket-prod`).
- Tags the bucket with the current workspace.

## Files
- `main.tf` — All resources and outputs
- `variables.tf` — Input variable for AWS region
- `provider.tf` — AWS provider configuration

## Usage
1. **Initialize Terraform:**
   ```bash
   terraform init
   ```
2. **Create/select a workspace:**
   ```bash
   terraform workspace new dev
   terraform workspace select dev
   # or for prod
'terraform workspace new prod
   terraform workspace select prod
   ```
3. **Apply:**
   ```bash
   terraform apply
   ```
4. **Check Output:**
   - The bucket name will include the workspace name.

5. **Cleanup:**
   ```bash
   terraform destroy
   ```

## Notes
- Each workspace creates a separate S3 bucket.
- Bucket names must be globally unique. If you get a name conflict, change the prefix in `main.tf`.
