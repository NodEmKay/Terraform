resource "aws_instance" "server" {
  ami                  = var.ami
  instance_type        = var.instance_type
  iam_instance_profile = var.iam_instance_profile

  tags = {
    Name = var.instance_name
  }

  lifecycle {
    prevent_destroy = true
  }
}