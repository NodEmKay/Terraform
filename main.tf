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
  count         = 2
  ami           = "ami-0b6c6ebed2801a5cb" # Amazon Linux 2 AMI (update based on region)
  instance_type = "t2.medium"

  tags = {
    Name = "Dev-Server0001"
  }
}