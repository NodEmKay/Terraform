# 1. Create the VPC with the specific CIDR block
resource "aws_vpc" "my_vpc" {
  cidr_block           = "192.168.0.0/24"
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}

# 2. Create a Subnet within the VPC
resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "192.168.0.0/26" # Slicing a portion of the VPC CIDR
  availability_zone = "us-east-1a"

  tags = {
    Name = "main-subnet"
  }
}

# 3. Create a Security Group to allow SSH
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 4. Create the EC2 Instance
resource "aws_instance" "my_server" {
  ami           = "ami-0ebfd141b224c8c72" # Amazon Linux 2023 in us-east-1
  instance_type = "t2.micro"

  # Placement in the custom network
  subnet_id              = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  # Explicit dependency (Optional, as subnet_id already creates an implicit one)
  depends_on = [aws_vpc.my_vpc]

  tags = {
    Name = "Terraform-EC2"
  }
}