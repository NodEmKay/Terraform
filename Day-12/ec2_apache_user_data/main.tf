# Deploy EC2 with Apache using user_data

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "ec2-apache-userdata-${var.environment}"
    Environment = var.environment
    ManagedBy = "Terraform"
  }
}

resource "aws_security_group" "web_sg" {
  name        = "ec2-apache-userdata-sg-${var.environment}"
  description = "Allow HTTP and SSH"
  vpc_id      = var.vpc_id

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

  tags = {
    Name = "ec2-apache-userdata-sg-${var.environment}"
    Environment = var.environment
    ManagedBy = "Terraform"
  }
}
