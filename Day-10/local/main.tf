locals {
  region = "us-east-1"
  instance_type = "t2.micro"
  ami = "ami-0532be01f26a3de55"
}
resource "aws_instance" "local-pc1" {
    ami           = local.ami
    instance_type = local.instance_type
    tags = {
      Name = "local-pc1"
    }
}