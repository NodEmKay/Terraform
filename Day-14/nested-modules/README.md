# Nested Modules Terraform Example

## Overview
This project demonstrates how to use nested modules in Terraform to provision AWS infrastructure in a clean, modular, and reusable way. The root configuration wires together local modules for network, security, and compute, each encapsulating a specific responsibility.

## Why Is This Code Important?
- **Real-World Structure:** Mirrors how production Terraform codebases are organized for clarity, scalability, and team collaboration.
- **Reusability:** Each module can be reused or extended in other projects, saving time and reducing errors.
- **Separation of Concerns:** Network, security, and compute logic are isolated, making the code easier to maintain and audit.
- **Best Practices:** Demonstrates variable usage, outputs, and wiring between modules, which are essential for professional Terraform development.
- **Troubleshooting:** Shows how to resolve compatibility issues with registry modules by using direct resources when needed.

## How Is This Useful?
- **Learning:** Great for practicing advanced Terraform patterns beyond single-file or flat configurations.
- **Prototyping:** Quickly adapt modules for new environments or requirements.
- **Team Projects:** Enables multiple people to work on different infrastructure components independently.
- **Extensibility:** Easily add more modules (e.g., ALB, RDS) or swap out implementations as your needs grow.

## Project Structure
```
nested-modules/
├── main.tf            # Root: wires modules together
├── variables.tf       # Root variables
├── provider.tf        # AWS provider config
├── terraform.tfvars   # Variable values
├── modules/
│   ├── network/       # VPC and subnets
│   ├── security/      # Security group (SSH only)
│   └── compute/       # EC2 instance
```

## What This Deploys
- **VPC:** 192.168.7.0/24 with two public subnets (192.168.7.0/25, 192.168.7.128/25)
- **Security Group:** Allows only SSH (port 22) from anywhere
- **EC2 Instance:** Amazon Linux 2, in the first public subnet, using your specified key pair

## Usage
1. Edit `terraform.tfvars` to set your AWS region, key pair, and other variables.
2. From the `nested-modules` directory, run:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```
3. Use the output instance ID to find your EC2 instance in the AWS console.

## FAQ
- **Why not use the registry EC2 module?**
  Compatibility issues with the latest AWS provider were resolved by using a direct `aws_instance` resource, which is simpler and more reliable for this example.
- **How do I add more features?**
  Create new modules in the `modules/` directory and wire them up in `main.tf`.
- **How do I allow more ports?**
  Edit the `modules/security/main.tf` to add more ingress rules.

---
This example is a practical foundation for building robust, production-ready Terraform infrastructure using modular design. Adapt and extend as your needs grow!