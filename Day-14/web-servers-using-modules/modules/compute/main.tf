# modules/compute/main.tf

resource "aws_instance" "web" {
  count                     = 2
  ami                       = var.ami_id
  instance_type             = var.instance_type
  subnet_id                 = var.subnet_ids[count.index]
  vpc_security_group_ids    = [var.sg_id]
  key_name                  = var.key_name
  associate_public_ip_address = true
  user_data = var.user_data
  tags = {
    Name = "${var.ec2_name}-${count.index + 1}"
  }
}

output "instance_ids" {
  value = aws_instance.web[*].id
}
