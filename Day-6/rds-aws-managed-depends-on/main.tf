# 1. Create a Security Group for MariaDB
resource "aws_security_group" "mariadb_sg" {
  name        = "mariadb-prod-sg"
  description = "Allow MariaDB traffic"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # Restricted to internal VPC
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2. Define the MariaDB RDS Instance
resource "aws_db_instance" "mariadb_instance" {
  identifier            = var.db_identifier
  engine                = "mariadb"
  engine_version        = "11.4.8" # Explicit version as requested
  instance_class        = var.db_instance_class
  allocated_storage     = 20
  max_allocated_storage = 100
  
  db_name  = var.db_name
  username = var.db_username
  
  # AWS Managed Password
  manage_master_user_password = true

  # Networking
  vpc_security_group_ids = [aws_security_group.mariadb_sg.id]
  publicly_accessible    = false
  multi_az               = true

  # Lifecycle and Protection
  skip_final_snapshot = false
  deletion_protection = true

  # Explicit Dependency
  depends_on = [
    aws_security_group.mariadb_sg
  ]

  tags = {
    Environment = "production"
    Engine      = "MariaDB-11.4.8"
  }
}