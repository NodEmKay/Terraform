resource "aws_instance" "dev" {
  ami           = var.dev_ami
  instance_type = var.dev_instance_type

  tags = {
    Name = "dev-server"
  }
}

resource "aws_instance" "test" {
  ami           = var.test_ami
  instance_type = var.test_instance_type

  tags = {
    Name = "test-server"
  }
}

resource "aws_instance" "prod" {
  ami           = var.prod_ami
  instance_type = var.prod_instance_type

  tags = {
    Name = "prod-server"
  }
}
