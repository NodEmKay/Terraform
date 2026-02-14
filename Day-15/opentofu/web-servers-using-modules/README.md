

# Web Servers on AWS — Simple Modular Terraform Example

This project uses Terraform modules to build a basic, scalable web server setup on AWS. Each part of the infrastructure is organized into its own module for clarity and easy reuse.

## What Does This Create?
- A custom VPC (private network)
- Two public subnets (in different availability zones)
- An internet gateway and route table for public access
- A security group (allows SSH and HTTP for demo)
- Two EC2 instances (web servers with Apache)
- An Application Load Balancer (ALB) to distribute traffic
- Outputs the ALB DNS name so you can access your web servers in a browser

## Project Structure

```
web-servers-using-modules/
├── main.tf          # Connects all modules
├── variables.tf     # Input variables
├── outputs.tf       # Outputs (like ALB DNS)
├── provider.tf      # AWS provider setup
├── terraform.tfvars # Variable values
├── modules/
│   ├── network/     # VPC, subnets, gateway
│   ├── security/    # Security group
│   ├── compute/     # EC2 web servers
│   └── alb/         # Load balancer
```

## How to Use
1. Make sure your AWS credentials are set up (via environment, profile, or AWS CLI).
2. Edit terraform.tfvars to set your VPC, subnet, instance, and ALB settings if needed.
3. Run:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```
4. After apply, Terraform will show the ALB DNS name. Open it in your browser to see your web servers.
5. To remove everything, run:
   ```bash
   terraform destroy
   ```

## Tips
- Only the key pair name is needed in Terraform; keep your private key safe for SSH.
- This demo allows SSH from anywhere—restrict this for real use.
- You can add more servers or subnets by changing variables.
- Each module is reusable and easy to extend.

---
This project is a simple, modular example for learning or starting real AWS infrastructure with Terraform.
## What This Deploys
