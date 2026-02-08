resource "aws_security_group" "this" {
  name        = "${var.name_prefix}-sg"
  description = "Webserver security group for ${var.name_prefix}"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}

locals {
  index_html = <<-EOT
  <html>
    <head>
      <title>Cricket Live Scores</title>
      <style>
        body { font-family: Arial, sans-serif; background: #e3f2fd; }
        .header { background: #1565c0; color: #fff; padding: 20px; text-align: center; }
        .score { font-size: 2em; color: #1565c0; margin: 40px; text-align: center; }
      </style>
    </head>
    <body>
      <div class="header">
        <h1>🏏 Cricket Live Scores</h1>
        <h2>Welcome to ${var.name_prefix} (Instance: $(curl -s http://169.254.169.254/latest/meta-data/instance-id))</h2>
      </div>
      <div class="score">
        India: 245/3 (40.2 overs)<br/>
        Australia: 241/10 (50 overs)
      </div>
      <div style="text-align:center; color:#888;">Powered by Terraform AWS Module-1</div>
    </body>
  </html>
  EOT
}

resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.ssh_key_name
  vpc_security_group_ids = [aws_security_group.this.id]

  user_data = <<-EOF
  #!/bin/bash
  dnf update -y
  dnf install -y httpd
  systemctl enable httpd
  systemctl start httpd
  cat <<'HTML' > /var/www/html/index.html
  ${local.index_html}
  HTML
  EOF

  tags = {
    Name = "${var.name_prefix}-web"
  }
}

resource "null_resource" "copy_index" {
  depends_on = [aws_instance.this]

  provisioner "file" {
    source      = "${path.module}/index.html"
    destination = "/tmp/index.html"

    connection {
      type        = "ssh"
      host        = aws_instance.this.public_ip
      user        = "ec2-user"
      private_key = file(var.ssh_private_key_path)
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/index.html /var/www/html/index.html",
      "sudo chown apache:apache /var/www/html/index.html || sudo chown ec2-user:ec2-user /var/www/html/index.html",
      "sudo chmod 644 /var/www/html/index.html"
    ]

    connection {
      type        = "ssh"
      host        = aws_instance.this.public_ip
      user        = "ec2-user"
      private_key = file(var.ssh_private_key_path)
    }
  }
}
