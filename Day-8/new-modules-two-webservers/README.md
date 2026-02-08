

# Terraform AWS Two Webservers Modular Example

This project demonstrates a production-style, modular Terraform setup for deploying two EC2 web servers (one for cricket, one for football) on AWS. Each server is managed via its own module, and all configuration is controlled from the root using variables and tfvars files. The web content is provisioned using a null_resource and SSH file copy for maximum flexibility.



## Directory Structure

```
new-modules-two-webservers/
├── main.tf                # Root config: calls both modules, passes all variables
├── variables.tf           # Root variable declarations (no defaults for prod)
├── terraform.tfvars       # All real values (region, AMI, key, SG rules, etc.)
├── module-1/
│   ├── main.tf            # Module 1: EC2 + Apache + SG + null_resource file copy
│   ├── variables.tf       # Module 1 variable declarations (no values)
│   └── index.html         # Cricket-themed web page
└── module-2/
   ├── main.tf            # Module 2: EC2 + Apache + SG + null_resource file copy
   ├── variables.tf       # Module 2 variable declarations (no values)
   └── index.html         # Football-themed web page
```



## How it Works
- Each module creates an EC2 instance with Apache installed and a security group, but all settings (AMI, instance type, key, SG rules, SSH private key path) are passed from the root.
- The root main.tf instantiates both modules, passing all required variables.
- Each module uses a null_resource with file and remote-exec provisioners to copy a custom index.html (cricket or football) to the EC2 instance after it is up.
- All real values are set in terraform.tfvars for easy environment switching.



## Usage
1. Edit `terraform.tfvars` with your values:
   - region, AMI IDs, key pair name, instance types, security group rules, and ssh_private_key_path (path to your private key for SSH provisioners).
2. Place your cricket and football index.html files in module-1 and module-2 folders (already provided).
3. Initialize:
   ```bash
   terraform init
   ```
4. Plan:
   ```bash
   terraform plan -var-file=terraform.tfvars
   ```
5. Apply:
   ```bash
   terraform apply -var-file=terraform.tfvars
   ```
6. Access:
   - Find the public IPs in the outputs or AWS console.
   - Visit `http://<public_ip>` to see the cricket or football themed web page.



## Notes & Best Practices
- All modules are generic and reusable—no hardcoded values.
- All real values (AMI, key, instance type, SG rules, region, ssh_private_key_path) are set in root terraform.tfvars.
- Security group rules are fully parameterized for each module.
- No default values for production variables—enforces explicit configuration.
- Restrict security group rules for production (do not use 0.0.0.0/0 for SSH).
- Use null_resource provisioners only for post-boot configuration (like copying files); avoid for critical infrastructure.



## Clean Up
To destroy all resources:
```bash
terraform destroy -var-file=terraform.tfvars
```


---


## Pro Tips & Troubleshooting

- **Variable Management:**
   - Do not put real values in module variables.tf—keep all values in root tfvars.
   - Remove all defaults for production variables to avoid accidental deployments with wrong settings.

- **Security Group Rules:**
   - Parameterize all SG rules (ingress/egress) for flexibility.
   - Pass rules from tfvars, not hardcoded in modules.

- **Provider Region:**
   - Remove region default from variables.tf and set it in tfvars for environment flexibility.

- **SSH Provisioners:**
   - You must have the private key file locally (ssh_private_key_path) that matches the key pair name used for the EC2 instance.
   - The key pair name is for AWS to inject the public key; the private key is for SSH access and provisioners.
   - The private key file must exist and be readable by Terraform.

- **Common Problems & Solutions:**
   - **Terraform prompts for variables:** Ensure all required variables are set in tfvars.
   - **AWS permission errors (UnauthorizedOperation):**
      - Check that your IAM user/role has the correct permissions for EC2 and SG operations.
      - Make sure you are using the same credentials/profile in both the AWS Console and Terraform CLI.
      - If blocked by a Service Control Policy (SCP), contact your AWS admin to update the policy.
   - **Module variable errors:** Always declare new variables in root variables.tf if you add new module inputs.
   - **Formatting:** Use `terraform fmt` to keep your code clean and readable.
   - **Provisioner errors:**
      - If you see file(path) errors, make sure ssh_private_key_path points to a real file on your machine.
      - If SSH fails, check that your security group allows SSH from your IP and that the key matches the instance.
      - If index.html is not updated, check /var/log/cloud-init.log and /var/log/user-data.log on the instance.

---
