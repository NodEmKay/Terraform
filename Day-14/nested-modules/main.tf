module "network" {
  source   = "./modules/network"
  vpc_name = var.vpc_name
  cidr     = var.vpc_cidr
}

module "security" {
  source = "./modules/security"
  sg_name = "allow-ssh"
  vpc_id  = module.network.vpc_id
  tags    = var.tags
}

module "compute" {
  source              = "./modules/compute"
  instance_name       = var.instance_name
  ami                 = var.ami
  instance_type       = var.instance_type
  subnet_id           = module.network.public_subnet_ids[0]
  security_group_ids  = [module.security.security_group_id]
  key_name            = var.key_name
  tags                = var.tags
}

output "vpc_id" {
  value = module.network.vpc_id
}

output "instance_id" {
  value = module.compute.instance_id
}

output "security_group_id" {
  value = module.security.security_group_id
}
