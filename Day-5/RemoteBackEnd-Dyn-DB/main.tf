resource "aws_key_pair" "aws_linux" {
  key_name   = "aws_linux"
  public_key = file(var.public_key_path)
}
resource "aws_key_pair" "ubuntu_key" {
  key_name   = "ubuntu_linux"
  public_key = file(var.public_key_path)
}
resource "aws_instance" "aws_linux" {
ami           = var.ami
instance_type = var.instance_type
key_name      = aws_key_pair.aws_linux.key_name

tags = {
 Name = var.instance_name
}
}

resource "aws_instance" "aws_linux-1" {
ami           = var.ami
instance_type = var.instance_type
key_name      = aws_key_pair.aws_linux.key_name

tags = {
 Name = "${var.instance_name}-2"
}
}

resource "aws_instance" "aws_linux-3" {
ami           = var.ami
instance_type = var.instance_type
key_name      = aws_key_pair.aws_linux.key_name

tags = {
 Name = "${var.instance_name}-3"
}
}
resource "aws_instance" "aws_linux-4" {
ami           = var.ami
instance_type = var.instance_type
key_name      = aws_key_pair.aws_linux.key_name

tags = {
 Name = "${var.instance_name}-4"
}
}

resource "aws_instance" "aws_linux-5" {
ami           = var.ami
instance_type = var.instance_type
key_name      = aws_key_pair.aws_linux.key_name

tags = {
 Name = "${var.instance_name}-5"
}
}

resource "aws_instance" "aws_linux-6" {
ami           = var.ami
instance_type = var.instance_type
key_name      = aws_key_pair.aws_linux.key_name

tags = {
 Name = "${var.instance_name}-6"
}
}