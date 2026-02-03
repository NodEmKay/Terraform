Simple EC2 example

Usage:

```bash
cd Day-8/modules/dev
terraform init
terraform plan -out plan.tfplan
terraform apply "plan.tfplan"
```

Notes:
- By default the configuration will lookup the latest Amazon Linux 2 AMI in the selected region.
- Provide `-var 'key_name=your-key'` to attach an existing key pair.
- Provide `-var 'ami=ami-xxxx'` to override the AMI lookup.
