

data "aws_ami" "ubuntu_dev" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "ubuntu_test" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "ubuntu_prod" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "ubuntu_uat" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "dev" {
  ami           = data.aws_ami.ubuntu_dev.id
  instance_type = "t2.micro"
}

resource "aws_instance" "test" {
  ami           = data.aws_ami.ubuntu_test.id
  instance_type = "t2.micro"
}

resource "aws_instance" "prod" {
  ami           = data.aws_ami.ubuntu_prod.id
  instance_type = "t2.micro"
}

resource "aws_instance" "uat" {
  ami           = data.aws_ami.ubuntu_uat.id
  instance_type = "t2.micro"
}

