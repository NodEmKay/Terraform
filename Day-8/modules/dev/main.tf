module "ec2_instance" {
  source      = "../ec2-instance"
  ami_id      = var.ami_id
  type        = var.type
  key_name    = var.key_name
  tags        = var.tags
}
