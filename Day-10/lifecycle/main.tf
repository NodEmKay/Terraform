resource "aws_instance" "one" {
  ami           = "ami-0c02fb55956c7d316" # changed AMI to force replacement
  instance_type = "t2.micro"
  tags = {
    Name = "one-ec2"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "two" {
  ami           = "ami-0532be01f26a3de55"
  instance_type = "t2.micro"
  tags = {
    Name = "one-ec2"
  }
  lifecycle {
    create_before_destroy = true
  }
}

