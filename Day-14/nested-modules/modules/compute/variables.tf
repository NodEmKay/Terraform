variable "instance_name" {
  description = "Name for the EC2 instance."
  type        = string
}

variable "ami" {
  description = "AMI ID for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance."
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs."
  type        = list(string)
}

variable "key_name" {
  description = "Key pair name for SSH access."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the instance."
  type        = map(string)
  default     = {}
}
