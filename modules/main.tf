provider "aws" {
  region = "us-east-1"
}
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "NodeEmkay"

    workspaces {
      name = "Terraform"
    }
  }
}

resource "aws_instance" "example" {
  count         = 4
  ami           = "ami-0532be01f26a3de55" # Amazon Linux 2 AMI (update based on region)
  instance_type = "t2.micro"

  tags = {
    Name = "Dev-Server0001"
  }
}