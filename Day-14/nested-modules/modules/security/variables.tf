variable "sg_name" {
  description = "Name for the security group."
  type        = string
  default     = "allow-ssh"
}

variable "vpc_id" {
  description = "VPC ID to associate with the security group."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the security group."
  type        = map(string)
  default     = {}
}
