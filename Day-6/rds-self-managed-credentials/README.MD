# **Production RDS MySQL Deployment — Terraform Module**

This Terraform configuration provisions a **high‑availability, production‑grade MySQL RDS instance** inside a dedicated VPC.  
It includes all required networking components, security controls, and operational safeguards expected in a real production environment.

---

##**What This Infrastructure Creates**

### **1. VPC & Networking**
A dedicated production VPC:

- CIDR: `10.0.0.0/16`
- DNS hostnames + DNS support enabled
- Two private subnets across **different Availability Zones**  
  - `10.0.10.0/24` (us-east-1a)  
  - `10.0.11.0/24` (us-east-1b)

These subnets are used exclusively for RDS to ensure isolation and high availability.

---

### **2. RDS Subnet Group**
A subnet group named **`prod-db-subnet-group`**, containing both private subnets.  
AWS requires at least two subnets in different AZs for Multi‑AZ RDS deployments.

---

### **3. Security Group**
A dedicated RDS security group:

- Allows inbound MySQL traffic (`3306/tcp`) **only from inside the VPC**
- Allows outbound traffic to the internet (for AWS service access)
- Ensures the database is **not exposed publicly**

---

### **4. MySQL RDS Instance (Production‑Ready)**
A fully managed MySQL 8.0 RDS instance with:

- Instance class: `db.t3.medium`
- Allocated storage: 20 GB  
- Storage autoscaling up to 100 GB  
- Multi‑AZ enabled for high availability  
- Automatic password management via AWS Secrets Manager  
- Backups retained for 7 days  
- Controlled backup + maintenance windows  
- Deletion protection enabled  
- Final snapshot required on deletion  
- Private‑only (not publicly accessible)

This setup follows AWS best practices for production workloads.

---

## **File Structure**

```
.
├── main.tf        # Core Terraform resources
├── variables.tf   # (Optional) Input variables
├── outputs.tf     # (Optional) Outputs for other modules
└── README.md      # Documentation
```

---

## **How to Use**

### **1. Initialize Terraform**
```
terraform init
```

### **2. Review the execution plan**
```
terraform plan
```

### **3. Apply the configuration**
```
terraform apply
```

Terraform will provision:

- VPC  
- Subnets  
- Subnet group  
- Security group  
- RDS instance  

---

## **Security Notes**

- The RDS instance is **not publicly accessible**  
- Passwords are managed automatically using **AWS Secrets Manager**  
- Only internal VPC traffic can reach the database  
- Deletion protection prevents accidental data loss  
- A final snapshot is always taken before destruction  

---

## **Production Best Practices Included**

| Feature | Enabled | Purpose |
|--------|---------|---------|
| Multi‑AZ | ✔️ | High availability |
| Storage autoscaling | ✔️ | Prevents storage exhaustion |
| Backup retention | ✔️ (7 days) | Disaster recovery |
| Maintenance window | ✔️ | Controlled patching |
| Deletion protection | ✔️ | Prevent accidental deletion |
| Final snapshot | ✔️ | Safe teardown |
| Private subnets | ✔️ | No public exposure |

---

## **Requirements**

- Terraform v1.0+  
- AWS CLI configured  
- IAM permissions to manage VPC, RDS, and networking resources  

---

## **Next Steps**

You can extend this setup by adding:

- Application subnets  
- NAT gateways  
- Route tables  
- Monitoring dashboards  
- Parameter groups  
- Secrets Manager rotation  

---
