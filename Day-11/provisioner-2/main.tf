resource "aws_security_group" "apache_access" {
  name        = "allow_apache"
  description = "Allow HTTP and SSH inbound traffic"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # HTTP for demo; restrict for production
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # SSH for demo; restrict for production
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "apache_example" {
  ami                    = "ami-0532be01f26a3de55" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.apache_access.id]
  key_name               = "key101" # Update if your key pair name is different

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "echo '<h1>Hello from Apache provisioned by Terraform!</h1>' | sudo tee /var/www/html/index.html"
    ]
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:/Users/muthu/.ssh/key101.pem")
    host        = self.public_ip
  }

  tags = {
    Name = "ApacheProvisioner"
  }
}
