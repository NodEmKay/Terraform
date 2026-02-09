# modules/alb/variables.tf

variable "lb_name" {}
variable "tg_name" {}
variable "vpc_id" {}
variable "subnet_ids" { type = list(string) }
variable "sg_id" {}
variable "instance_ids" { type = list(string) }
