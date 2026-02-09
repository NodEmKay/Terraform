# modules/network/main.tf

resource "aws_vpc" "custom" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.custom.id
  cidr_block              = var.subnet_a_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.az_a
  tags = {
    Name = var.subnet_a_name
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.custom.id
  cidr_block              = var.subnet_b_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.az_b
  tags = {
    Name = var.subnet_b_name
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.custom.id
  tags = {
    Name = var.igw_name
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.custom.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = var.rt_name
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_assoc_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

output "vpc_id" {
  value = aws_vpc.custom.id
}

output "public_subnet_ids" {
  value = [aws_subnet.public.id, aws_subnet.public_b.id]
}
