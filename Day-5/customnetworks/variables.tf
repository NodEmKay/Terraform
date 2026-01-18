variable "aws_region" {
  default = "us-east-1"
}

variable "az" {
  default = "us-east-1a"
}

variable "ami" {
  default = "ami-07ff62358b87c7116"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "public_key_path" {
  description = "Path to your SSH public key"
  default     = "~/.ssh/id_ed25519.pub"
}
