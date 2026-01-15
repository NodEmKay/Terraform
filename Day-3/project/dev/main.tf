provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "server" {
  count         = length(var.instance_names) # Better than hardcoding '3'
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = var.instance_names[count.index]
  }
}