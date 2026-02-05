locals {
  dev = {
    environment   = "dev"
    region        = "us-east-1"
    instance_type = "t2.micro"
    ami           = "ami-0532be01f26a3de55"
    tags = {
      Name        = "dev-pc1"
      Environment = "dev"
    }
  }
  prod = {
    environment   = "prod"
    region        = "us-east-1"
    instance_type = "t2.micro"
    ami           = "ami-0532be01f26a3de55"
    tags = {
      Name        = "prod-pc1"
      Environment = "prod"
    }
  }
  local = {
    environment   = "local"
    region        = "us-east-1"
    instance_type = "t2.micro"
    ami           = "ami-0532be01f26a3de55"
    tags = {
      Name        = "local-pc1"
      Environment = "local"
    }
  }
}

resource "aws_instance" "local-pc1" {
  ami           = local.local.ami
  instance_type = local.local.instance_type
  tags          = local.local.tags
}

resource "aws_instance" "dev-pc1" {
  ami           = local.dev.ami
  instance_type = local.dev.instance_type
  tags          = local.dev.tags
}

resource "aws_instance" "prod-pc1" {
  ami           = local.prod.ami
  instance_type = local.prod.instance_type
  tags          = local.prod.tags
}