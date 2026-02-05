resource "aws_instance" "one" {
  ami           = "ami-0532be01f26a3de55"
  instance_type = "t2.micro"
  tags = {
    Name = "one-ec2"
  }
}

resource "aws_instance" "two" {
  ami           = "ami-0532be01f26a3de55"
  instance_type = "t2.micro"
  tags = {
    Name = "one-ec2"
  }
}

resource "aws_s3_bucket" "one_s3_bucket" {
  bucket = "one-s3-bucket-01111"
}