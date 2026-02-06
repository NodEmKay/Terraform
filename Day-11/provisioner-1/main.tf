resource "aws_security_group" "ssh_access" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # For demo; restrict for production
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "provisioner_example" {
  ami                    = "ami-0532be01f26a3de55" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ssh_access.id]
  key_name               = "key101"

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "echo 'Hello from Terraform provisioner!' > /tmp/terraform-provisioner.txt"
    ]
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:/Users/muthu/.ssh/key101.pem")
    host        = self.public_ip
  }

  tags = {
    Name = "ProvisionerPractice"
  }
}
