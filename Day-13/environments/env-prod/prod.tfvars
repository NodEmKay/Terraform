vpc_cidr = "10.20.0.0/16"
subnet_cidrs = ["10.20.1.0/24", "10.20.2.0/24"]
availability_zones = ["us-east-1a", "us-east-1b"]
tags = { Environment = "prod", ManagedBy = "Terraform" }

ami = "ami-0b6c6ebed2801a5cb"
instance_type = "t3.medium"
security_group_ids = ["sg-yyyyyyyyyyyyyyyyy"]

allocated_storage = 100
engine = "mysql"
instance_class = "db.t3.medium"
db_name = "proddb"
username = "produser"
password = "prodpass123"
db_subnet_group_name = "prod-db-subnet-group"

bucket_name = "my-prod-bucket-2026"
