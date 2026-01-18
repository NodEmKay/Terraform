############################################
# Provider
############################################
provider "aws" {
  region = var.aws_region
}

############################################
# VPC
############################################
resource "aws_vpc" "vpc_ppa" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc_ppa"
  }
}

############################################
# PUBLIC SUBNET
############################################
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.vpc_ppa.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.az

  tags = {
    Name = "public"
  }
}

############################################
# PRIVATE SUBNET
############################################
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.vpc_ppa.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.az

  tags = {
    Name = "private"
  }
}

############################################
# INTERNET GATEWAY
############################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_ppa.id

  tags = {
    Name = "igw"
  }
}

############################################
# PUBLIC ROUTE TABLE
############################################
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc_ppa.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

############################################
# NAT GATEWAY + EIP
############################################
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "natgw"
  }
}

############################################
# PRIVATE ROUTE TABLE
############################################
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc_ppa.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
}

############################################
# KEY PAIR FOR BASTION
############################################
resource "aws_key_pair" "bastion_key" {
  key_name   = "bastion-key"
  public_key = file(var.public_key_path)
}

############################################
# SECURITY GROUP
############################################
resource "aws_security_group" "ppa_sg" {
  name   = "ppa-sg"
  vpc_id = aws_vpc.vpc_ppa.id

  tags = {
    Name = "ppa-sg"
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
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

############################################
# BASTION HOST (PUBLIC SUBNET)
############################################
resource "aws_instance" "bastion_01" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.ppa_sg.id]
  key_name               = aws_key_pair.bastion_key.key_name

  tags = {
    Name = "bastion-01"
  }
}

############################################
# PRIVATE INSTANCE
############################################
resource "aws_instance" "app_01" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.ppa_sg.id]
  key_name               = aws_key_pair.bastion_key.key_name

  tags = {
    Name = "app-01"
  }
}