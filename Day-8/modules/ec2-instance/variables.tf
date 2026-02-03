variable "ami_id" {
  description = "AMI ID to use for the instance"
  type        = string
}

variable "type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "Optional EC2 key pair name"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Map of tags to apply to the instance"
  type        = map(string)
}
