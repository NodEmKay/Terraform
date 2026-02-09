module "vpc" {
  source = "../../aws-modules/vpc"
  cidr_block = var.vpc_cidr
  subnet_cidrs = var.subnet_cidrs
  availability_zones = var.availability_zones
  tags = var.tags
}

module "ec2" {
  source = "../../aws-modules/ec2"
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = module.vpc.subnet_ids[0]
  security_group_ids = var.security_group_ids
  tags = var.tags
}

module "rds" {
  source = "../../aws-modules/rds"
  allocated_storage = var.allocated_storage
  engine = var.engine
  instance_class = var.instance_class
  db_name = var.db_name
  username = var.username
  password = var.password
  security_group_ids = var.security_group_ids
  db_subnet_group_name = var.db_subnet_group_name
  tags = var.tags
}

module "s3" {
  source = "../../aws-modules/s3"
  bucket_name = var.bucket_name
  tags = var.tags
}
