# -------------------------
# SSH Key Pair
# -------------------------
resource "aws_key_pair" "generated" {
  key_name   = "mykey"
  public_key = file("~/.ssh/mykey.pub")
}

# -------------------------
# VPC
# -------------------------
resource "aws_vpc" "vpc_01" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# -------------------------
# Public Subnet
# -------------------------
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vpc_01.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

# -------------------------
# Internet Gateway
# -------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_01.id
}

# -------------------------
# Route Table
# -------------------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc_01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# -------------------------
# Security Group
# -------------------------
resource "aws_security_group" "ssh" {
  name        = "allow_ssh"
  description = "Allow SSH"
  vpc_id      = aws_vpc.vpc_01.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # tighten later
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -------------------------
# EC2 Instance
# -------------------------
resource "aws_instance" "web" {
  ami           = "ami-0c02fb55956c7d316" # Ubuntu 22.04
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id

  vpc_security_group_ids = [aws_security_group.ssh.id]

  key_name = aws_key_pair.generated.key_name
}