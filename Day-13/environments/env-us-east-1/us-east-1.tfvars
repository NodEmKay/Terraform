vpc_cidr = "10.30.0.0/16"
subnet_cidrs = ["10.30.1.0/24", "10.30.2.0/24"]
availability_zones = ["us-east-1a", "us-east-1b"]
tags = { Environment = "us-east-1", ManagedBy = "Terraform" }

ami = "ami-0532be01f26a3de55"
instance_type = "t3.micro"

allocated_storage = 20
engine = "mysql"
instance_class = "db.t3.micro"
db_name = "eastdb1"
username = "eastuser"
password = "eastpass123"

bucket_name = "my-east-bucket-2026"
