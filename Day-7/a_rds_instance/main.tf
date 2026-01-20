# 1. Security Group to allow public traffic on port 3306
resource "aws_security_group" "rds_public_sg" {
  name        = "rds_public_access"
  description = "Allow inbound MySQL traffic from anywhere"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # WARNING: This allows the whole internet to try and connect
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2. The RDS Instance
resource "aws_db_instance" "my_public_db" {
  identifier           = "my-test-database"
  allocated_storage    = 20               # Minimum for gp2
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"            # Use a modern version
  instance_class       = "db.t3.micro"    # Free-tier eligible class
  
  # DB Name and Credentials
  db_name              = "testdb"         # This creates the database 'testdb' inside the instance
  username             = "admin"
  password             = "YourSecurePassword123" # Use a strong password!

  # Networking
  publicly_accessible  = true             # KEY: Makes it reachable via public IP
  vpc_security_group_ids = [aws_security_group.rds_public_sg.id]
  
  # Maintenance & Cleanup
  skip_final_snapshot  = true             # Allows 'terraform destroy' to work without creating a backup
}

# 3. Output the endpoint so you can connect
output "db_endpoint" {
  value = aws_db_instance.my_public_db.endpoint
}