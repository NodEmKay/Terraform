# **Terraform AWS VPC â€“ Infrastructure Deployment**

This project provisions a productionâ€‘ready AWS network environment using Terraform.  
It includes a VPC, public and private subnets, routing, NAT gateway, security groups, key pairs, and EC2 instances (bastion + private app host).

---

## **í³Œ Architecture Overview**

The infrastructure deployed includes:

- **VPC** with CIDR `10.0.0.0/16`
- **Public Subnet** (`10.0.1.0/24`)
- **Private Subnet** (`10.0.2.0/24`)
- **Internet Gateway** for public subnet outbound access
- **NAT Gateway** for private subnet outbound access
- **Public Route Table** â†’ IGW
- **Private Route Table** â†’ NAT Gateway
- **Security Group** allowing HTTP, HTTPS, SSH
- **Key Pair** for SSH access
- **Bastion Host** in public subnet
- **Private EC2 Instance** in private subnet
- **Outputs** for key resource identifiers

---

## **í³ Project Structure**

```
.
â”œâ”€â”€ main.tf
â”œâ”€â”€ variables.tf
â”œâ”€â”€ outputs.tf
â””â”€â”€ README.md
```

---

## **íº€ What Terraform Builds**

### **Networking**
- Creates a VPC with public and private subnets.
- Attaches an Internet Gateway.
- Allocates an Elastic IP for NAT.
- Deploys a NAT Gateway in the public subnet.
- Creates route tables:
  - Public RT â†’ IGW
  - Private RT â†’ NAT Gateway
- Associates subnets with their respective route tables.

### **Security**
- Creates a security group (`ppa-sg`) allowing:
  - HTTP (80)
  - HTTPS (443)
  - SSH (22)
  - All outbound traffic

### **Compute**
- **Bastion Host** in public subnet  
  - Uses the generated key pair  
  - Public IP assigned  
  - Used to SSH into private instances

- **Private App Instance** in private subnet  
  - No public IP  
  - Internet access via NAT  
  - SSH access only through bastion

### **Key Pair**
- Terraform imports your local public key and creates an AWS key pair.

---

## **í·© Variables**

Defined in `variables.tf`:

- `aws_region` â€“ AWS region to deploy into  
- `az` â€“ Availability zone  
- `ami` â€“ AMI ID for EC2 instances  
- `instance_type` â€“ EC2 instance type  
- `public_key_path` â€“ Path to your SSH public key  

---

## **í³¤ Outputs**

After apply, Terraform prints:

- Bastion public IP  
- NAT Gateway public IP  
- Private instance ID  
- Public subnet ID  
- Private subnet ID  
- VPC ID  

These outputs help with SSH access and debugging.

---

## **í» ï¸ Deployment Steps**

### **1. Initialize Terraform**
```
terraform init
```

### **2. Review the plan**
```
terraform plan
```

### **3. Apply the configuration**
```
terraform apply
```

---

## **í´ Accessing the Private Instance**

1. SSH into the bastion host:
```
ssh -i ~/.ssh/<your-key> ec2-user@<bastion-public-ip>
```

2. From the bastion, SSH into the private instance:
```
ssh ec2-user@10.0.2.x
```
