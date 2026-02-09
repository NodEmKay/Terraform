# modules/compute/variables.tf

variable "ami_id" {}
variable "instance_type" {}
variable "subnet_ids" { type = list(string) }
variable "sg_id" {}
variable "key_name" {}
variable "user_data" {}
variable "ec2_name" {}
