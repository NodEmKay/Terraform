# Count with a map example
variable "instance_names" {
  type    = map(string)
  default = {
    "web"  = "t2.micro"
    "db"   = "t2.small"
  }
}

resource "aws_instance" "per_role" {
  count         = length(keys(var.instance_names))
  ami           = "ami-0532be01f26a3de55"
  instance_type = values(var.instance_names)[count.index]
  tags = {
    Name = keys(var.instance_names)[count.index]
  }
}
