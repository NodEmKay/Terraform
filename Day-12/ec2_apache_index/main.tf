resource "null_resource" "directory_audit" {
  provisioner "local-exec" {
    command = "bash -c 'echo [AUDIT] Terraform apply run at $(date) >> ${path.module}/directory_activity_audit.log'"
  }
  triggers = {
    always_run = timestamp()
  }
}
resource "aws_security_group" "web_sg" {
  name        = "web-sg-costco-demo"
  description = "Allow HTTP and SSH"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_instance" "web" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y || sudo apt-get update -y",
      "sudo yum install -y httpd || sudo apt-get install -y apache2",
      "sudo systemctl enable httpd || sudo systemctl enable apache2",
      "sudo systemctl start httpd || sudo systemctl start apache2"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }
}

resource "null_resource" "deploy_index" {
  provisioner "file" {
    source      = "${path.module}/index.html"
    destination = "/tmp/index.html"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = aws_instance.web.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/index.html /var/www/html/index.html",
      "sudo chown root:root /var/www/html/index.html",
      "sudo chmod 644 /var/www/html/index.html"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = aws_instance.web.public_ip
    }
  }

  provisioner "local-exec" {
    command = "echo 'Deployed index.html with hash: ${self.triggers.index_hash} at $(date)' >> ${path.module}/index_deploy_audit.log"
  }

  triggers = {
    index_hash = filesha256("${path.module}/index.html")
  }
  depends_on = [aws_instance.web]
}

#output "web_public_ip" {
  #value = aws_instance.web.public_ip
#}
