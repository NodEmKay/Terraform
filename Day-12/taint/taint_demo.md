# Taint Demo

## What is terraform taint?

`terraform taint` marks a resource as tainted, forcing Terraform to destroy and recreate it on the next apply.

## How to use
1. Deploy the EC2 instance with `terraform apply`.
2. Run:
   ```
   terraform taint aws_instance.taint_demo
   ```
3. Run `terraform apply` again. The instance will be destroyed and recreated.
4. To remove taint without recreation:
   ```
   terraform untaint aws_instance.taint_demo
   ```

## Why use taint?
- For testing resource recreation
- To force a fresh deployment
- For troubleshooting
