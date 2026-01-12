resource "aws_instance" "Ubuntu-Image" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}