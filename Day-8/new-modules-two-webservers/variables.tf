variable "ssh_private_key_path" {
  description = "Path to the private key for SSH connection to EC2 instances"
  type        = string
}
# Security group rules for module-1
variable "ingress_rules_1" {
  description = "List of ingress rules for the security group for module-1"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "egress_rules_1" {
  description = "List of egress rules for the security group for module-1"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
# Security group rules for module-2
variable "ingress_rules" {
  description = "List of ingress rules for the security group for module-2"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "egress_rules" {
  description = "List of egress rules for the security group for module-2"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
variable "region" {
  description = "AWS region to deploy into"
  type        = string
}


variable "ami_id_1" {
  description = "AMI ID for webserver 1"
  type        = string
}

variable "ami_id_2" {
  description = "AMI ID for webserver 2"
  type        = string
}


variable "ssh_key_name_1" {
  description = "AWS key pair name for module-1"
  type        = string
}

variable "ssh_key_name_2" {
  description = "AWS key pair name for module-2"
  type        = string
}

variable "ssh_allowed_cidr" {
  description = "CIDR allowed to SSH into instances"
  type        = string
  default     = "0.0.0.0/0"
}

variable "instance_type_1" {
  description = "Instance type for module-1"
  type        = string
}

variable "instance_type_2" {
  description = "Instance type for module-2"
  type        = string
}
