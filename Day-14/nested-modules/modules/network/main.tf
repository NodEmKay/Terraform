module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"

  name = var.vpc_name
  cidr = var.cidr

  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["192.168.7.0/25", "192.168.7.128/25"]
  enable_dns_hostnames = true
  enable_dns_support   = true
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnets
}

output "default_security_group_id" {
  value = module.vpc.default_security_group_id
}
