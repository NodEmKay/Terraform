terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "ec2_instance" {
  source         = "../Day-8-modules/ec2"
  ami            = var.ami
  instance_type  = var.instance_type
  instance_names = var.instance_names
}