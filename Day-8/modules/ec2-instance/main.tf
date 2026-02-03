resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.type
  key_name      = var.key_name != "" ? var.key_name : null
  tags          = var.tags
}
