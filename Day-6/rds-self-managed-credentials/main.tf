# --- VPC & Networking ---
resource "aws_vpc" "prod_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "prod-vpc"
    Environment = "production"
  }
}

# RDS requires at least two subnets in different AZs for High Availability
resource "aws_subnet" "prod_db_subnet_a" {
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "prod-db-subnet-1a"
  }
}

resource "aws_subnet" "prod_db_subnet_b" {
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = "10.0.11.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "prod-db-subnet-1b"
  }
}

# --- Database Networking ---
resource "aws_db_subnet_group" "prod_db_subnet_group" {
  name        = "prod-db-subnet-group"
  description = "Subnet group for production RDS instances"
  subnet_ids  = [aws_subnet.prod_db_subnet_a.id, aws_subnet.prod_db_subnet_b.id]

  tags = {
    Name = "prod-db-subnet-group"
  }
}

resource "aws_security_group" "prod_db_sg" {
  name        = "prod-db-security-group"
  description = "Allow MySQL traffic from internal app tier"
  vpc_id      = aws_vpc.prod_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # Only allow traffic from within the VPC
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --- RDS Instance ---
resource "aws_db_instance" "prod_mysql" {
  identifier           = "prod-book-rds"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.medium" # Production usually requires more than micro
  allocated_storage     = 20
  max_allocated_storage = 100 # Enable Storage Autoscaling
  
  db_name  = "bookstore_prod"
  username = "admin"

  # Password management
  manage_master_user_password = true

  # Networking & Security
  db_subnet_group_name   = aws_db_subnet_group.prod_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.prod_db_sg.id]
  publicly_accessible    = false # Never public in production
  multi_az               = true  # High Availability for production

  # Backup & Maintenance
  backup_retention_period = 7
  backup_window           = "02:00-03:00"
  maintenance_window      = "sun:04:00-sun:05:00"
  
  # Protection
  deletion_protection = true
  skip_final_snapshot = false # Always take a final snapshot in prod!
  final_snapshot_identifier = "prod-book-rds-final-snapshot"

  tags = {
    Name        = "production-mysql-instance"
    Environment = "production"
    ManagedBy   = "terraform"
  }
}