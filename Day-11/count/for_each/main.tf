variable "instances" {
  description = "Map of instance names to instance types"
  type        = map(string)
  default = {
    app1 = "t2.micro"
    app2 = "t2.small"
    app3 = "t2.nano"
  }
}

resource "aws_instance" "for_each_example" {
  for_each      = var.instances
  ami           = "ami-0532be01f26a3de55" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = each.value
  tags = {
    Name = each.key
  }
}
