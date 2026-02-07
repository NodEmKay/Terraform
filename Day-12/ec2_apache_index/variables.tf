variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "ami" {
  description = "AMI ID for EC2 instance (Amazon Linux 2 recommended)"
  type        = string
  default     = "ami-0c02fb55956c7d316"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "AWS EC2 Key Pair name"
  type        = string
  default     = "key101"
}

variable "private_key_path" {
  description = "Path to private key for SSH"
  type        = string
  default     = "C:/Users/muthu/.ssh/key101.pem"
}
