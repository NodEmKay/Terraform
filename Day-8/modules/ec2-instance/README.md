## EC2 Instance Module

This module provisions a single AWS EC2 instance.

### Inputs
- `ami_id`: AMI ID for the instance (required)
- `type`: EC2 instance type (required)
- `key_name`: Optional EC2 key pair name
- `tags`: Map of tags to apply

### Outputs
- `instance_id`: The EC2 instance ID
- `public_ip`: Public IP of the instance
- `public_dns`: Public DNS name

### Usage Example
```hcl
module "ec2_instance" {
  source      = "../ec2-instance"
  ami_id      = "ami-xxxxxxxx"
  type        = "t2.micro"
  key_name    = "your-key"
  tags        = {
    Environment = "dev"
    Name        = "dev-server"
  }
}
```
