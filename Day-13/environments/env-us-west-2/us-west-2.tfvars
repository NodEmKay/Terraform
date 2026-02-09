vpc_cidr = "10.40.0.0/16"
subnet_cidrs = ["10.40.1.0/24", "10.40.2.0/24"]
availability_zones = ["us-west-2a", "us-west-2b"]
tags = { Environment = "us-west-2", ManagedBy = "Terraform" }

ami = "ami-055a9df0c8c9f681c"
instance_type = "t3.micro"

allocated_storage = 20
engine = "mysql"
instance_class = "db.t3.micro"
db_name = "westdb"
username = "westuser"
password = "westpass123"

bucket_name = "my-west-bucket-2026"
