# Terraform AWS Infrastructure Learning Repository

This repository is a progressive Terraform tutorial for AWS infrastructure. It is organized by day-based examples that progress from simple EC2 setups to more advanced patterns like reusable modules and serverless architectures.

## Architecture Overview

- Modular structure: each `Day-N/` contains a standalone Terraform example showcasing one or more AWS services.
- Environment management: use Terraform workspaces (`dev`, `test`, `prod`) and environment-specific `.tfvars` files.
- Remote state: examples use an S3 backend with an optional DynamoDB table for state locking.
- Dependencies: prefer implicit dependencies (resource references) over unnecessary `depends_on`.

## Example Directory Layout

```
Day-N/
├── main.tf        # primary resources
├── variables.tf   # input variables
├── outputs.tf     # outputs for other stacks
├── provider.tf    # provider configuration
├── backend.tf     # remote state backend (optional)
└── terraform.tfvars# default values for local testing
```

## Common Workflows

Environment-specific deployment (typical):

```bash
terraform workspace select dev
terraform init
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
```

Module usage:

- Place reusable modules under `./modules/`.
- Reference local modules with `source = "./modules/my_module"` or use registry modules.
- Run `terraform init` after adding or changing module sources.

State management:

- Configure an S3 bucket for remote state and a DynamoDB table for locking when collaborating.
- Example backend keys and names in examples are placeholders — replace them with environment-specific values.
- Always run `terraform init` after changing backend configuration.

## Project Conventions

- Resource naming: use predictable prefixes and include the environment, e.g. `${var.bucket_name_prefix}-${var.environment}-bucket`.
- Tags: include at least `Environment` and `ManagedBy = "Terraform"`.

Provider example:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 7.0"
    }
  }
}
```

Lambda functions:

- Keep Python or other runtime code in separate source files next to `main.tf` in the same example directory.
- Use `data "archive_file"` or an external build step to create a zip artifact for deployment.
- Follow `handler = "lambda_function.lambda_handler"` naming conventions when using Python.

Security groups:

- For bastion hosts, examples may open SSH (port 22) broadly for demo purposes — tighten this for production.
- Private instances should allow only VPC-internal access unless explicitly required.

## Common Patterns and Recommendations

- Prefer implicit references between resources rather than `depends_on` unless sequencing is required.
- Use environment-specific tfvars files (`dev.tfvars`, `prod.tfvars`) for differences in sizes, counts, and names.
- Expose useful outputs (IDs, ARNs, endpoints) for cross-stack consumption.
- Use lifecycle settings like `prevent_destroy = true` sparingly and only for critical production resources.

## Integration Points

- AWS services used in examples include EC2, VPC, S3, RDS, Lambda, DynamoDB, and IAM roles.
- Examples show simple IAM role and assume-role patterns for Lambda execution.
- S3 → Lambda triggers and Secrets Manager usage are demonstrated in relevant Day folders.

## Examples and Further Reading

See these directories for concrete, working examples referenced in the guide:

- `Day-4/remote-state/`
- `Day-7/lambda_function_simple_code_s3_trigger/`
- `Day-8/terraform-practice/modules/`

If you want, I can further shorten sections, add quick-start commands, or convert this into a README template.