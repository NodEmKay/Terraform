data "aws_subnet" "test" {
  filter {
    name   = "tag:Name"
    values = ["test"]
  }

}

data "aws_subnet" "dev" {
  filter {
    name   = "tag:Name"
    values = ["dev"]
  }

}

data "aws_subnet" "prod" {
  filter {
    name   = "tag:Name"
    values = ["prod"]
  }

}

data "aws_subnet" "uat" {
  filter {
    name   = "tag:Name"
    values = ["uat"]
  }

}

resource "aws_instance" "test" {
  ami           = "ami-0532be01f26a3de55"
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.test.id
  
}

resource "aws_instance" "prod" {
  ami           = "ami-0532be01f26a3de55"
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.prod.id
  
}

resource "aws_instance" "uat" {
  ami           = "ami-0532be01f26a3de55"
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.uat.id
  
}