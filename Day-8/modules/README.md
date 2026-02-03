# Day-8 Terraform Modules

Overview
- This folder (`Day-8/modules`) is a parent module that defines a provider and calls three child modules: `dev`, `test`, and `prod`.
- Each child module is intentionally minimal and contains only `main.tf` and `variables.tf`.
- The parent controls provider configuration and per-environment inputs.

Directory structure

- Day-8/modules/
  - main.tf           -> parent module (provider + module blocks)
  - variables.tf      -> parent-level variables (region, per-env AMIs, sizes, common tags)
  - README.md         -> this file
  - dev/              -> child module (main.tf, variables.tf)
  - test/             -> child module (main.tf, variables.tf)
  - prod/             -> child module (main.tf, variables.tf)

Child module contract
- Inputs each child expects (declared in `variables.tf` inside the child):
  - `ami_id` (string) : AMI ID to launch
  - `type` (string)   : EC2 instance type (default `t2.micro`)
  - `key_name` (string, optional) : existing EC2 key pair name
  - `tags` (map(string)) : tags to attach to the instance
- Child `main.tf` creates a single `aws_instance` resource using those inputs.
- Child modules do not declare providers; the parent supplies the provider.

Parent variables (summary of `variables.tf` in this folder)
- `aws_region` : AWS region used by provider (default `us-east-1`)
- `key_name` : Optional key name passed to all modules
- `common_tags` : Map of tags merged into each module's tags
- Per-environment AMI and size variables (e.g. `ami_dev`, `instance_type_dev`, `ami_test`, etc.)

Usage

Initialize and plan from the parent directory so the provider and all modules are available:

```bash
cd Day-8/modules
terraform init
terraform plan -out plan.tfplan
```

Apply the generated plan (this creates all three instances):

```bash
terraform apply "plan.tfplan"
```

Example: override a single environment AMI at plan time

```bash
terraform plan -out plan.tfplan -var 'ami_dev=ami-0532be01f26a3de55'
```

Notes & recommendations
- Running `terraform plan` or `apply` from a child module (e.g., `Day-8/modules/dev`) will not work as-is because the provider is defined in the parent.
- Provide a `key_name` via `-var 'key_name=your-key'` if you want SSH access.
- Child modules expect a valid AMI in `ami_id`; leave empty to supply from parent defaults or override per environment.
- This layout is intended for learning and experimentation. For production, consider state isolation (workspaces or separate state backends) and tighter naming/tags.

If you want, I can also:
- Add a small `Makefile` or script to run `init/plan/apply` per-environment
- Add example `terraform.tfvars` files for each environment
- Add outputs at parent level that expose each module's instance ID and IP
