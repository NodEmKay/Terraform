resource "aws_instance" "server" {
  ami                  = var.ami
  instance_type        = var.instance_type
  iam_instance_profile = var.iam_instance_profile
  subnet_id            = var.subnet_id

  tags = {
    Name = var.instance_name
  }

  #t lifecycle {
   #prevent_destroy = true
  #}
}