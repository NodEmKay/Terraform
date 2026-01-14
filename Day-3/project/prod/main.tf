provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "server" {
  ami           = var.ami
  instance_type = var.instance_type
}