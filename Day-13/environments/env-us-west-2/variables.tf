variable "vpc_cidr" {}
variable "subnet_cidrs" { type = list(string) }
variable "availability_zones" { type = list(string) }
variable "tags" { type = map(string) }

variable "ami" {}
variable "instance_type" {}

variable "allocated_storage" {}
variable "engine" {}
variable "instance_class" {}
variable "db_name" {}
variable "username" {}
variable "password" {}

variable "bucket_name" {}
