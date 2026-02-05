resource "aws_instance" "One1" {
    ami           = "ami-0532be01f26a3de55"
    instance_type = "t2.micro"
    tags = {
        Name = "One1"
    }
}

resource "aws_security_group" "allow_common" {
  name        = "allow_common"
  description = "Allow SSH, HTTP, HTTPS inbound traffic"
  # vpc_id      = "vpc-xxxxxxxx" # Add if needed

  dynamic "ingress" {
    for_each = [22, 80, 443]
    content {
      description      = "Allow port ${ingress.value} from anywhere"
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}