# Terraform: VPC + Public Subnet + EC2 + SSH Key Pair

This Terraform configuration builds a minimal but fully functional AWS environment:

- A VPC (`10.0.0.0/16`)
- A public subnet (`10.0.1.0/24`)
- An Internet Gateway
- A route table with a default route to the Internet
- A security group allowing SSH
- A Terraform‑managed SSH key pair
- A public EC2 instance using that key pair

This setup is ideal for learning, testing, or building a clean homelab-style AWS environment.

---

## Prerequisites

Before deploying, ensure you have:

- **Terraform v1.0+**
- **AWS CLI configured**  
  ```bash
  aws configure
  ```
- A generated SSH key pair on your machine  
  ```bash
  ssh-keygen -t rsa -b 4096 -f ~/.ssh/mykey
  ```

Terraform will upload the **public key** (`mykey.pub`) to AWS.

---

## Project Structure

```
.
├── main.tf
└── README.md
```

---

## Deployment Steps

### 1. Initialize Terraform
```bash
terraform init
```

### 2. Validate configuration
```bash
terraform validate
```

### 3. Preview changes
```bash
terraform plan
```

### 4. Apply and create resources
```bash
terraform apply
```

Type `yes` when prompted.

---

## Connecting to the EC2 Instance

After apply completes, find the EC2 public IP in the AWS console or by adding an output block.

SSH into the instance:

```bash
ssh -i ~/.ssh/mykey ubuntu@<EC2_PUBLIC_IP>
```

---

## Cleanup

To destroy all resources:

```bash
terraform destroy
```

---

## Architecture Overview

| Component | Purpose |
|----------|---------|
| **VPC** | Isolated network environment |
| **Public Subnet** | Hosts the EC2 instance with public IP |
| **Internet Gateway** | Enables outbound internet access |
| **Route Table** | Routes `0.0.0.0/0` to the IGW |
| **Security Group** | Allows SSH (port 22) |
| **Key Pair** | Created by Terraform using your local public key |
| **EC2 Instance** | Ubuntu server accessible via SSH |

---

## Notes & Best Practices

- Replace `0.0.0.0/0` with your IP for better security.
- Store private keys securely; never commit them to Git.
- For production, split resources into modules and use remote state (S3 + DynamoDB).
- Add `variables.tf` and `outputs.tf` for cleaner structure.

---

## Optional Enhancements

- Add a private subnet + NAT Gateway
- Add multiple subnets across AZs
- Add ALB/NLB for real workloads
- Add S3 backend for Terraform state

---

Happy building and experimenting!
```

---
