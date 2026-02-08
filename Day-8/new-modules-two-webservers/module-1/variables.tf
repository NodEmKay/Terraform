variable "ssh_private_key_path" {
  description = "Path to the private key for SSH connection to EC2 instance"
  type        = string
}
variable "ingress_rules" {
  description = "List of ingress rules for the security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "egress_rules" {
  description = "List of egress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
variable "ami_id" {
  description = "AMI ID for the instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "ssh_key_name" {
  description = "AWS key pair name"
  type        = string
}

variable "ssh_allowed_cidr" {
  description = "CIDR allowed to SSH"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
}