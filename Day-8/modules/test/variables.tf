variable "ami_id" {
  description = "AMI ID to use for the instance"
  type        = string
  default     = "ami-0532be01f26a3de55"
}

variable "type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Optional EC2 key pair name"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Map of tags to apply to the instance"
  type        = map(string)
  default     = {
    Environment = "test"
    Name        = "test-server"
  }
}
