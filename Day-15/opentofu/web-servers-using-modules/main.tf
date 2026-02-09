# main.tf
# Root module: reference modules and orchestrate resources here.

module "network" {
  source         = "./modules/network"
  vpc_cidr       = var.vpc_cidr
  vpc_name       = var.vpc_name
  subnet_a_cidr  = var.subnet_a_cidr
  subnet_b_cidr  = var.subnet_b_cidr
  subnet_a_name  = var.subnet_a_name
  subnet_b_name  = var.subnet_b_name
  az_a           = var.az_a
  az_b           = var.az_b
  igw_name       = var.igw_name
  rt_name        = var.rt_name
}

module "security" {
  source = "./modules/security"
  vpc_id = module.network.vpc_id
  sg_name = var.sg_name
}

module "compute" {
  source         = "./modules/compute"
  subnet_ids     = module.network.public_subnet_ids
  sg_id          = module.security.web_sg_id
  ami_id         = var.ami_id
  instance_type  = var.instance_type
  key_name       = var.key_name
  user_data      = var.user_data
  ec2_name       = var.ec2_name
}

module "alb" {
  source       = "./modules/alb"
  vpc_id       = module.network.vpc_id
  subnet_ids   = module.network.public_subnet_ids
  sg_id        = module.security.web_sg_id
  instance_ids = module.compute.instance_ids
  lb_name      = var.lb_name
  tg_name      = var.tg_name
}
