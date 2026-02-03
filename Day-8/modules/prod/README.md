Simple EC2 example using a shared module

## Prod Environment - EC2 Instance

This directory deploys a prod EC2 instance using the shared ec2-instance module.

### Usage
```bash
cd Day-8/modules/prod
terraform init
terraform plan
terraform apply
```

### Notes
- Variables are set in variables.tf for prod-specific values (AMI, type, tags).
- The ec2-instance module provisions the instance and outputs instance_id, public_ip, and public_dns.
- To change the AMI, update the ami_id variable in variables.tf.
