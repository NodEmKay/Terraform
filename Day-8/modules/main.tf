provider "aws" {
  region = var.aws_region
}

module "dev" {
  source        = "./dev"
  ami_id        = var.ami_dev
  type          = var.instance_type_dev
  key_name      = var.key_name
  tags          = merge(var.common_tags, { Environment = "dev", Name = "dev-instance" })
}

module "test" {
  source        = "./test"
  ami_id        = var.ami_test
  type          = var.instance_type_test
  key_name      = var.key_name
  tags          = merge(var.common_tags, { Environment = "test", Name = "test-instance" })
}

module "prod" {
  source        = "./prod"
  ami_id        = var.ami_prod
  type          = var.instance_type_prod
  key_name      = var.key_name
  tags          = merge(var.common_tags, { Environment = "prod", Name = "prod-instance" })
}
