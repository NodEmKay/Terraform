variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "instance_names" {
  description = "Name tag for the EC2 instance"
  type        = string
}