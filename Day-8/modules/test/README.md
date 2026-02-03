Simple EC2 example using a shared module

## Test Environment - EC2 Instance

This directory deploys a test EC2 instance using the shared ec2-instance module.

### Usage
```bash
cd Day-8/modules/test
terraform init
terraform plan
terraform apply
```

### Notes
- Variables are set in variables.tf for test-specific values (AMI, type, tags).
- The ec2-instance module provisions the instance and outputs instance_id, public_ip, and public_dns.
- To change the AMI, update the ami_id variable in variables.tf.
