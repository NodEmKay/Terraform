aws_region = "us-east-1"
vpc_name   = "nested-demo-vpc"
vpc_cidr   = "192.168.7.0/24"
instance_name = "demo-ec2"
ami            = "ami-0532be01f26a3de55" # Amazon Linux 2 in us-east-1
instance_type  = "t2.micro"
key_name       = "web-key"
# Optionally, add tags
# tags = {
#   Environment = "dev"
#   ManagedBy   = "Terraform"
# }
