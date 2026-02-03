provider "aws" {
    region = var.aws_region
  }
    resource "aws_instance" "EC2_Instance" {
        ami           = var.ami
        instance_type = var.instance_type
    
        tags = {
            Name = var.instance_name
        }
    }
  