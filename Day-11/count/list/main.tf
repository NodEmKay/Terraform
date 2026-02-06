# Count with a list example
variable "subnet_ids" {
  type    = list(string)
  default = ["subnet-013506a21a9afaee8", "subnet-0ed6cdd250143ee96"]
}

resource "aws_instance" "per_subnet" {
  count         = length(var.subnet_ids)
  ami           = "ami-0532be01f26a3de55"
  instance_type = "t2.micro"
  subnet_id     = var.subnet_ids[count.index]
  tags = {
    Name = "per-subnet-${count.index}"
  }
}
