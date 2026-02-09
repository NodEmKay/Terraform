# 🚀 Day-13: Modular AWS Terraform Project

Welcome to a modern, scalable, and production-ready AWS infrastructure-as-code example using Terraform modules and environment separation.

---

## 📦 Project Structure

```
Day-13/
├── aws-modules/         # Reusable modules for AWS resources
│   ├── ec2/
│   ├── rds/
│   ├── s3/
│   └── vpc/
├── environments/        # Environment-specific deployments
│   ├── env-test/
│   ├── env-prod/
│   ├── env-us-east-1/
│   └── env-us-west-2/
└── README.md
```

---

## 🌍 Environments

- Each environment (test, prod, etc.) has its own folder with:
  - `main.tf` — references modules and resources
  - `provider.tf` — AWS provider config
  - `variables.tf` — input variables
  - `*.tfvars` — environment-specific values

---

## 🧩 Modules

- All core AWS resources are defined as modules in `aws-modules/`:
  - `ec2/` — EC2 instance
  - `rds/` — RDS database
  - `s3/` — S3 bucket
  - `vpc/` — VPC and subnets
- Modules are referenced in each environment’s `main.tf` using the `source` attribute.

---

## 🚦 Quick Start

1. **Clone the repo and cd to your environment:**
   ```bash
   cd Day-13/environments/env-test   # or env-prod, etc.
   ```
2. **Initialize Terraform:**
   ```bash
   terraform init
   ```
3. **Plan and Apply:**
   ```bash
   terraform plan -var-file=test.tfvars
   terraform apply -var-file=test.tfvars
   ```
   *(Use prod.tfvars for prod, etc.)*

---

## 🛡️ Best Practices

- **Unique Resource Names:**
  - All resources are auto-suffixed with the environment name for uniqueness.
- **Separation of State:**
  - Each environment manages its own state for isolation and safety.
- **Sensitive Data:**
  - Store secrets (like DB passwords) in tfvars files or use a secrets manager.
- **Tagging:**
  - All resources are tagged with `Environment` and `ManagedBy` for traceability.
- **Security Groups:**
  - Each environment creates its own security group for EC2 and RDS.
- **No Hardcoded IDs:**
  - All IDs and names are parameterized for flexibility.

---

## 📝 Example tfvars (test.tfvars)

```hcl
vpc_cidr = "10.10.0.0/16"
subnet_cidrs = ["10.10.1.0/24", "10.10.2.0/24"]
availability_zones = ["us-east-1a", "us-east-1b"]
tags = { Environment = "test", ManagedBy = "Terraform" }

ami = "ami-0532be01f26a3de55"
instance_type = "t3.micro"

allocated_storage = 20
engine = "mysql"
instance_class = "db.t3.micro"
db_name = "testdb"
username = "testuser"
password = "testpass123"

bucket_name = "my-test-bucket-2026"
```

---

## 🏆 Why This Structure?

- **Reusable:** One set of modules, many environments.
- **Safe:** No resource name collisions between environments.
- **Scalable:** Add new environments or modules easily.
- **Clear:** Each environment is self-contained and easy to manage.

---

## 📚 Further Reading

- [Terraform AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Modules Guide](https://developer.hashicorp.com/terraform/language/modules/develop)

---

## 💡 Tips

- Use remote state (S3 + DynamoDB) for team collaboration.
- Use workspaces for even finer environment separation if needed.
- Always review the plan before applying changes.

---

**Happy Terraforming!**
