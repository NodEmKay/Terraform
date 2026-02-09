resource "aws_instance" "server1" {
  ami           = "ami-0532be01f26a3de55"
  instance_type = "t2.medium"
    tags = {
        Name = "Server1"
    }
}