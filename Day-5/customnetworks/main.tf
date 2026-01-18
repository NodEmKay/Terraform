#Create a VPC in US East Region
resource "aws_vpc" "VPC-PPA" {
    cidr_block = "10.0.0.0/16"
    region = "us-east-1a"
    tags = {
      Name = "VPC-PPA"
    }
}    
# Create a Public Network
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.VPC-PPA.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "public"
    }
}
#Create a Private Network
resource "aws_subnet" "private" {
    vpc_id = aws_vpc.VPC-PPA.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "private"
    }
}
#Create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.VPC-PPA.id
}

#Attach internet gateway to VPC
resource "aws_internet_gateway_attachment" "igwtovpc" { 
    internet_gateway_id = aws_internet_gateway.igw.id
    vpc_id = aws_vpc.VPC-PPA.id
}

#Create  public route table and attach to IGW
resource "aws_route_table" "public-rt" {
    vpc_id = aws_vpc.VPC-PPA.id
 
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
    }
  
}

resource "aws_route_table_association" "a_prt_ps" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public-rt.id
  
}
#Create private route table
#Create Nat Gateway
#Subnet Association to private subnet
#Create a security group
resource "aws_security_group" "ppa_sg" {
  name   = "allow_tls"
  vpc_id = aws_vpc.VPC-PPA.id
  tags = {
    Name = "ppa-sg"
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #indicate all protocol 
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "bastion-01" {
    ami = "ami-07ff62358b87c7116"
    instance_type = "t2.micro"
    subnet_id = "aws_subnet.public.id"
    vpc_security_group_ids = [aws_security_group.ppa_sg]
}

