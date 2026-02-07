# Terraform Always-Tainted Null Resource Example

This example demonstrates how to use a `null_resource` with an always-changing trigger to force recreation on every `terraform apply`.

## Features
- Creates a `null_resource` that is always destroyed and recreated on every apply
- Runs a local-exec provisioner each time
- Outputs the null_resource ID

## Usage Steps
1. Run `terraform init`.
2. Run `terraform apply`.
3. Observe that the null_resource is created and the provisioner runs.
4. Run `terraform apply` again. The null_resource will be destroyed and recreated, and the provisioner will run again.

## How it works
- The `triggers` block uses `always_run = timestamp()`, which always changes, so Terraform always recreates the resource.

## Files
- `main.tf`: null_resource with always-changing trigger
- `outputs.tf`: Outputs null_resource ID
