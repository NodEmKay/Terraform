# Conditional creation example
variable "create_instance" {
  type    = bool
  default = true # Default value set to true to enable resource creation via conditional count
}

resource "aws_instance" "conditional" {
  count         = var.create_instance ? 1 : 0
  ami           = "ami-0532be01f26a3de55" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t2.micro"
  tags = {
    Name = "conditional-instance"
  }
}
