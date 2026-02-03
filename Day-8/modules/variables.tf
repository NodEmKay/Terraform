variable "aws_region" {
  description = "AWS region for all modules"
  type        = string
  default     = "us-east-1"
}

variable "key_name" {
  description = "Optional EC2 key pair name"
  type        = string
  default     = ""
}

variable "common_tags" {
  description = "Common tags applied to all instances"
  type        = map(string)
  default     = {
    ManagedBy = "Terraform"
  }
}

variable "ami_dev" {
  description = "AMI for dev"
  type        = string
  default     = "ami-0532be01f26a3de55"
}

variable "instance_type_dev" {
  description = "Instance type for dev"
  type        = string
  default     = "t2.micro"
}

variable "ami_test" {
  description = "AMI for test"
  type        = string
  default     = "ami-0532be01f26a3de55"
}

variable "instance_type_test" {
  description = "Instance type for test"
  type        = string
  default     = "t2.micro"
}

variable "ami_prod" {
  description = "AMI for prod"
  type        = string
  default     = "ami-0532be01f26a3de55"
}

variable "instance_type_prod" {
  description = "Instance type for prod"
  type        = string
  default     = "t2.micro"
}
