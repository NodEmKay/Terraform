vpc_cidr = "10.10.0.0/16"
subnet_cidrs = ["10.10.1.0/24", "10.10.2.0/24"]
availability_zones = ["us-east-1a", "us-east-1b"]
tags = { Environment = "test", ManagedBy = "Terraform" }

ami = "ami-0532be01f26a3de55"
instance_type = "t3.micro"
security_group_ids = ["sg-xxxxxxxxxxxxxxxxx"]

allocated_storage = 20
engine = "mysql"
instance_class = "db.t3.micro"
db_name = "testdb"
username = "testuser"
password = "testpass123"
db_subnet_group_name = "test-db-subnet-group"

bucket_name = "my-test-bucket-2026"
