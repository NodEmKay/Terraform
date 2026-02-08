terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}


module "webserver_1" {
  source = "./module-1"

  ami_id           = var.ami_id_1
  instance_type    = var.instance_type_1
  ssh_key_name     = var.ssh_key_name_1
  ssh_allowed_cidr = var.ssh_allowed_cidr
  name_prefix      = "module-1"
  ingress_rules    = var.ingress_rules_1
  egress_rules     = var.egress_rules_1
  ssh_private_key_path = var.ssh_private_key_path
}


module "webserver_2" {
  source = "./module-2"

  ami_id           = var.ami_id_2
  instance_type    = var.instance_type_2
  ssh_key_name     = var.ssh_key_name_2
  ssh_allowed_cidr = var.ssh_allowed_cidr
  name_prefix      = "module-2"
  ingress_rules    = var.ingress_rules
  egress_rules     = var.egress_rules
  ssh_private_key_path = var.ssh_private_key_path
}
