# Terraform — Day‑1 Introduction

Terraform is an open‑source Infrastructure as Code (IaC) tool that lets you define, provision, and manage cloud infrastructure using declarative configuration files. Instead of clicking around in AWS, Azure, or GCP consoles, Terraform allows you to automate everything with code — making infrastructure predictable, repeatable, and version‑controlled

## Why Terraform?

### ✔ Infrastructure as Code (IaC)
Write your infrastructure in `.tf` files so it can be reviewed, versioned, and reused.

### ✔ Multi‑Cloud Support
One tool works across AWS, Azure, GCP, VMware, Kubernetes, GitHub, and hundreds of providers.

### ✔ Predictable Deployments
Terraform shows you exactly what will change before applying it.

### ✔ Reproducibility
You can recreate entire environments (dev, test, prod) from the same code.

### ✔ Collaboration & Safety
Remote state + locking prevents conflicts when teams work together.

---

## How Terraform Works (Simple Explanation)

Terraform uses three key components:

| Component | Purpose |
|----------|---------|
| **Configuration (.tf files)** | Your desired infrastructure |
| **State file** | Tracks what Terraform created |
| **Providers** | Plugins that talk to cloud APIs |

Terraform compares **your code** with **the real world** and decides what to create, update, or delete.

---

## Installing Terraform

### **Ubuntu / Linux**
```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt install terraform
```

### **macOS**
```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

### **Windows**
Install via **Chocolatey**:
```powershell
choco install terraform
```

Verify installation:
```bash
terraform -version
```

---

## Terraform Workflow (The 3‑Step Cycle)

1. **Write** → Define resources in `.tf` files  
2. **Plan** → Preview what Terraform will do  
3. **Apply** → Create/update infrastructure  

This cycle repeats as you evolve your environment.

---

## Important Terraform Commands

### **Initialize a project**
```bash
terraform init
```

### **Validate configuration**
```bash
terraform validate
```

### **Format code**
```bash
terraform fmt
```

### **Preview changes**
```bash
terraform plan
```

### **Apply changes**
```bash
terraform apply
```

### **Destroy infrastructure**
```bash
terraform destroy
```

### **Show current state**
```bash
terraform show
```

### **List resources in state**
```bash
terraform state list
```

---

## Example Project Structure

```
.
├── main.tf
├── variables.tf
├── outputs.tf
└── Day-1.md
```

---

## Best Practices for Beginners

- Keep your first project simple (VPC + EC2 is perfect)
- Use `terraform fmt` to keep code clean
- Never commit your `terraform.tfstate` file
- Use remote state (S3 + DynamoDB) when working in teams
- Break large configs into modules as you grow

---

## Summary

Terraform gives you:

- Automation  
- Consistency  
- Version control  
- Repeatability  
- Multi‑cloud flexibility  

It’s one of the most important tools for modern DevOps, SRE, and cloud engineering.

---

Happy learning and experimenting with Terraform!
