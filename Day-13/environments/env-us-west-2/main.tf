# Security group for EC2 and RDS
resource "aws_security_group" "ec2_rds" {
  name        = "west-ec2-rds-sg"
  description = "Allow SSH and HTTP for EC2 and RDS"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags
}
# Create a DB subnet group for RDS
resource "aws_db_subnet_group" "rds" {
  name       = "west-db-subnet-group"
  subnet_ids = module.vpc.subnet_ids
  tags       = var.tags
}
module "vpc" {
  source = "../../aws-modules/vpc"
  cidr_block = var.vpc_cidr
  subnet_cidrs = var.subnet_cidrs
  availability_zones = var.availability_zones
  tags = var.tags
}

module "ec2" {
  source = "../../aws-modules/ec2"
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = module.vpc.subnet_ids[0]
  security_group_ids = [aws_security_group.ec2_rds.id]
  tags = var.tags
}

module "rds" {
  source = "../../aws-modules/rds"
  allocated_storage = var.allocated_storage
  engine = var.engine
  instance_class = var.instance_class
  db_name = var.db_name
  username = var.username
  password = var.password
  security_group_ids = [aws_security_group.ec2_rds.id]
  db_subnet_group_name = aws_db_subnet_group.rds.name
  tags = var.tags
}

module "s3" {
  source = "../../aws-modules/s3"
  bucket_name = var.bucket_name
  tags = var.tags
}
