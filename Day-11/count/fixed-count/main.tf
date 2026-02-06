# Fixed count example
resource "aws_instance" "fixed_count" {
  count         = 3
  ami           = "ami-0532be01f26a3de55"
  instance_type = "t2.micro"
  tags = {
    Name = "Dev-${count.index}"
  }
}
