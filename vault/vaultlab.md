Absolutely, Muthupandi â€” here is the **complete endâ€‘toâ€‘end guide** in clean, professional **README.md** format.  
You can copy this directly into your GitHub repo or project folder.

---

# í³˜ **Vault + Terraform + AWS RDS â€” Full Endâ€‘toâ€‘End Setup**

This guide walks through building a Vault server on AWS EC2, configuring S3 storage, unsealing Vault, connecting from your local machine, and using Terraform to create an AWS RDS instance using secrets stored in Vault.

---

## í¿¦ **1. Deploy Vault on EC2**

### **Launch EC2 Instance**
- Ubuntu 22.04 or 24.04  
- t3.micro or t3.small  
- Open ports:
  - `22` (SSH)
  - `8200` (Vault API)

### **Install Vault**
```bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt update
sudo apt install vault
```

### **Vault Configuration (`/etc/vault.d/vault.hcl`)**
```hcl
storage "s3" {
  bucket = "your-vault-bucket"
  region = "us-east-1"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}

ui = true
```

### **Start Vault**
```bash
sudo systemctl enable vault
sudo systemctl start vault
sudo systemctl status vault
```

---

## í¿¦ **2. Attach IAM Role to EC2**

### **Create IAM Role**
- Trusted entity: **EC2**
- Attach policy:  
  - `AmazonS3FullAccess` (lab only)

### **Attach Role to EC2**
EC2 â†’ Instance â†’ Actions â†’ Security â†’ Modify IAM Role

### **Verify IAM Role**
```bash
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

curl -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/iam/security-credentials/
```

---

## í¿¦ **3. Initialize & Unseal Vault**

### **Initialize**
```bash
vault operator init
```

Save:
- 5 unseal keys  
- 1 root token  

### **Unseal**
```bash
vault operator unseal
vault operator unseal
vault operator unseal
```

### **Login**
```bash
vault login
```

---

## í¿¦ **4. Create Secrets in Vault**

### **Enable KV Engine**
```bash
vault secrets enable -path=secret kv-v2
```

### **Store Secret**
```bash
vault kv put secret/app/config username="admin" password="SuperSecret123"
```

---

## í¿¦ **5. Connect From Local Machine (Windows + Git Bash)**

### **Install Vault CLI**
Download Vault for Windows â†’ extract â†’ place `vault.exe` in:

```
C:\vault\
```

Add to PATH.

### **Set Environment Variables**
```bash
export VAULT_ADDR="http://<VAULT-EC2-IP>:8200"
export VAULT_TOKEN="<your-root-token>"
```

### **Test**
```bash
vault status
```

---

## í¿¦ **6. Terraform Setup**

### **Project Structure**
```
vaultpractise/
  main.tf
```

### **Terraform Configuration (`main.tf`)**
```hcl
terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "vault" {
  address = "http://<VAULT-EC2-IP>:8200"
}

provider "aws" {
  region = "us-east-1"
}

data "vault_kv_secret_v2" "app_config" {
  mount = "secret"
  name  = "app/config"
}

resource "aws_db_instance" "mydb" {
  identifier           = "mydb"
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  username             = data.vault_kv_secret_v2.app_config.data["username"]
  password             = data.vault_kv_secret_v2.app_config.data["password"]
  skip_final_snapshot  = true
}

output "username" {
  value     = data.vault_kv_secret_v2.app_config.data["username"]
  sensitive = true
}

output "password" {
  value     = data.vault_kv_secret_v2.app_config.data["password"]
  sensitive = true
}
```

---

## í¿¦ **7. Run Terraform**

```bash
terraform init
terraform plan
terraform apply
```

Terraform will:

- Connect to Vault  
- Retrieve the secret  
- Create the RDS instance using Vault credentials  

Outputs will show:

```
username = <sensitive>
password = <sensitive>
```

---

## í¾‰ **You Now Have a Full Vault â†’ Terraform â†’ AWS Workflow**

This setup gives you:

- A secure Vault server on EC2  
- S3 backend for durability  
- IAM role authentication  
- Local Vault CLI access  
- Terraform reading secrets from Vault  
- Terraform creating AWS resources using those secrets  

A solid foundation for realâ€‘world DevOps and cloud automation.
