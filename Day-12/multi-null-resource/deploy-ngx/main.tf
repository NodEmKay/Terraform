provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "nginx_sg" {
  name        = "nginx-sg"
  description = "Allow SSH and HTTP"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "nginx" {
  ami           = "ami-0532be01f26a3de55" # Amazon Linux 2
  instance_type = "t2.micro"
  key_name      = "key101" # Update with your key pair
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  tags = {
    Name = "NginxDemo"
  }
}

resource "null_resource" "install_nginx" {
  triggers = {
    instance_id = aws_instance.nginx.id
    always_run = timestamp()
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("C:/Users/muthu/.ssh/key101.pem")
      host        = aws_instance.nginx.public_ip
    }
  }
}

resource "null_resource" "custom_index" {
  triggers = {
    instance_id = aws_instance.nginx.id
    always_run = timestamp()
  }
  depends_on = [null_resource.install_nginx]
  provisioner "remote-exec" {
    inline = [
      "echo '<h1>Deployed with Terraform and null_resource!</h1>' | sudo tee /usr/share/nginx/html/index.html"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("C:/Users/muthu/.ssh/key101.pem")
      host        = aws_instance.nginx.public_ip
    }
  }
}

resource "null_resource" "local_log" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = "echo Nginx deployed at %DATE% %TIME% >> nginx-deploy.log"
  }
}
