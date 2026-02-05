locals {
  ports = [22, 80, 443]
  cidrs = ["192.168.1.0/24", "10.0.0.0/8", "203.0.113.0/24"]
}

resource "aws_security_group" "multi_port_multi_cidr" {
  name        = "multi_port_multi_cidr"
  description = "Allow multiple ports from multiple CIDRs"

  dynamic "ingress" {
    for_each = local.ports
    content {
      description      = "Allow port ${ingress.value} from trusted networks"
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = local.cidrs
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
