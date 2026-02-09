variable "vpc_name" {
  description = "Name for the VPC."
  type        = string
  default     = "nested-demo-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.20.0.0/16"
}

variable "instance_name" {
  description = "Name for the EC2 instance."
  type        = string
  default     = "demo-ec2"
}

variable "ami" {
  description = "AMI ID for the EC2 instance."
  type        = string
  default     = "ami-0c02fb55956c7d316" # Amazon Linux 2 in us-east-1
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance."
  type        = string
  default     = ""
}

variable "security_group_ids" {
  description = "List of security group IDs."
  type        = list(string)
  default     = []
}

variable "key_name" {
  description = "Key pair name for SSH access."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to the instance."
  type        = map(string)
  default     = {}
}

variable "aws_region" {
  description = "AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}
