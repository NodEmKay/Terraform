# Count with filtered list example
variable "envs" {
  type    = list(string)
  default = ["dev", "prod", "test"]
}

locals {
  prod_envs = [for env in var.envs : env if env == "prod"]
}

resource "aws_instance" "only_prod" {
  count         = length(local.prod_envs)
  ami           = "ami-0532be01f26a3de55" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t2.micro"
  tags = {
    Name = "only-prod-${count.index}"
  }
}
