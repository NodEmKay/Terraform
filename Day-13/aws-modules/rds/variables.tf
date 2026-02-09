variable "allocated_storage" {}
variable "engine" {}
variable "instance_class" {}
variable "db_name" {}
variable "username" {}
variable "password" {}
variable "security_group_ids" { type = list(string) }
variable "db_subnet_group_name" {}
variable "tags" { type = map(string) }
