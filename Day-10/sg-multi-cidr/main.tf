resource "aws_security_group" "multi_cidr_sg" {
  name        = "multi_cidr_sg"
  description = "Allow SSH from multiple CIDRs"

  ingress {
    description      = "SSH from trusted networks"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["192.168.1.0/24", "10.0.0.0/8", "203.0.113.0/24"]
    ipv6_cidr_blocks = ["2001:db8::/32", "::1/128"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
