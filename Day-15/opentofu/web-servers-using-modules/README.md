# Web Servers Using Modules — Detailed AWS Terraform Example

## How This Differs from the Single-File Version (Important!)

This modular project is fundamentally different from the single-file (just-main-tf) approach in several important ways:

- **Separation of Concerns:**
  - Each major infrastructure component (network, security, compute, ALB) is defined in its own module directory, making the codebase easier to understand, maintain, and extend.
  - The single-file version puts all logic in one file, which is simple but can become hard to manage as complexity grows.

- **Reusability:**
  - Modules can be reused across different projects or environments with minimal changes.
  - The single-file approach is not reusable without copy-pasting and manual edits.

- **Scalability:**
  - Modular design allows you to add, remove, or update components independently, supporting larger and more complex infrastructure.
  - The single-file version is best for small demos or learning, not for scaling up.

- **Team Collaboration:**
  - Teams can work on different modules in parallel, with clear ownership and boundaries.
  - The single-file version is harder to collaborate on, as all changes happen in one place.

- **Production Alignment:**
  - This structure mirrors real-world, production-grade Terraform projects, making it easier to adopt best practices and integrate with CI/CD pipelines.
  - The single-file version is for rapid prototyping or learning, not for production.

- **Extensibility:**
  - New features (e.g., private subnets, NAT, RDS) can be added as new modules without disrupting existing code.
  - The single-file version requires editing the same file, increasing risk of errors.

**In summary:**
- Use this modular project for real-world, team-based, or production scenarios.
- Use the single-file version for quick demos, learning, or when you want everything visible in one place.

---

## Overview
This project provisions a highly available, load-balanced Apache web server cluster on AWS using a modular Terraform structure. Each major infrastructure component is encapsulated in its own module for clarity, reusability, and production alignment. This approach is ideal for real-world projects, team collaboration, and scalable infrastructure.

## Project Structure
```
web-servers-using-modules/
├── main.tf            # Assembles all modules and passes variables
├── variables.tf       # Input variable declarations
├── outputs.tf         # Useful outputs (ALB DNS, etc.)
├── provider.tf        # AWS provider config
├── terraform.tfvars   # Variable values for this environment
├── modules/
│   ├── network/       # VPC, subnets, IGW, route tables
│   ├── security/      # Security groups
│   ├── compute/       # EC2 instances, user_data
│   └── alb/           # Application Load Balancer, target group, listener
```

## What This Deploys
- **Custom VPC**: 192.168.5.0/24
- **Two Public Subnets**: 192.168.5.0/25 (us-east-1a), 192.168.5.128/25 (us-east-1b)
- **Internet Gateway & Route Table**: For public access
- **Security Group**: Allows SSH (22) & HTTP (80) from anywhere (demo default)
- **EC2 Instances (x2)**: Amazon Linux 2, Apache auto-installed, each in a different AZ
- **Application Load Balancer**: Spans both subnets for high availability
- **Target Group & Listener**: HTTP traffic routed to both web servers
- **Output**: ALB DNS for browser access

## Why Use Modules?
- **Separation of Concerns:** Each module manages a single responsibility (network, security, compute, ALB).
- **Reusability:** Modules can be reused across projects and environments.
- **Scalability:** Easily extend or replace modules as requirements grow.
- **Team Collaboration:** Clear boundaries for team ownership and code reviews.

## Usage
1. **Configure AWS Credentials:**
   - Ensure your AWS credentials are set (via environment, profile, or AWS CLI).
2. **Review/Edit terraform.tfvars:**
   - Adjust VPC, subnet, instance, and ALB settings as needed.
3. **Initialize Terraform:**
   ```bash
   terraform init
   ```
4. **Plan:**
   ```bash
   terraform plan
   ```
5. **Apply:**
   ```bash
   terraform apply
   ```
6. **Access the Web Servers:**
   - After apply, Terraform will output the ALB DNS name (load_balancer_dns).
   - Open it in your browser: `http://<alb_dns>`
   - You should see the Apache welcome page or a custom message from each server.

## Verification Steps
- **Web Test:**
  - Refresh the ALB DNS in your browser to see responses from both EC2s ("Hello from <hostname>").
- **SSH Test:**
  - SSH into each EC2 using the key specified in terraform.tfvars.
  - Check Apache status and the index.html file.
- **AWS Console:**
  - Confirm VPC, subnets, EC2s, ALB, and target group are present and healthy.
- **Cleanup:**
  - Destroy all resources with:
    ```bash
    terraform destroy
    ```

## Best Practices & Notes
- **Modular Design:** Each module is self-contained and reusable. For new features, add or extend modules.
- **Key Pair:** Only the key name is referenced; private key stays local for SSH.
- **Security:** Demo setup allows SSH from anywhere. Restrict this for production.
- **Scaling:** Increase EC2 count or add more subnets/AZs for greater availability.
- **Parameterization:** All settings (CIDRs, names, AMI, instance type, etc.) are variables for easy reuse.

## Extending This Example
- Add outputs for instance public IPs or other resources.
- Parameterize more settings or add environment-specific tfvars.
- Add private subnets, NAT, or RDS for a full-stack demo.
- Publish modules to a registry for team or public reuse.

---
**This project demonstrates a modular, production-style approach to AWS infrastructure with Terraform. For real-world use, follow AWS and Terraform best practices for security, modularity, and scalability.**
