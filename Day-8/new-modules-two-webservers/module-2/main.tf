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
      <title>Football Live Scores</title>
      <style>
        body { font-family: Arial, sans-serif; background: #f1f8e9; }
        .header { background: #388e3c; color: #fff; padding: 20px; text-align: center; }
        .score { font-size: 2em; color: #388e3c; margin: 40px; text-align: center; }
      </style>
    </head>
    <body>
      <div class="header">
        <h1>⚽ Football Live Scores</h1>
        <h2>Welcome to ${var.name_prefix} (Instance: $(curl -s http://169.254.169.254/latest/meta-data/instance-id))</h2>
      </div>
      <div class="score">
        Manchester United 2 - 1 Liverpool<br/>
        Barcelona 3 - 2 Real Madrid
      </div>
      <div style="text-align:center; color:#888;">Powered by Terraform AWS Module-2</div>
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
  apt-get update -y
  apt-get install -y apache2
  systemctl enable apache2
  systemctl start apache2
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
      user        = "ubuntu"
      private_key = file(var.ssh_private_key_path)
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/index.html /var/www/html/index.html",
      "sudo chown www-data:www-data /var/www/html/index.html || sudo chown ubuntu:ubuntu /var/www/html/index.html",
      "sudo chmod 644 /var/www/html/index.html"
    ]

    connection {
      type        = "ssh"
      host        = aws_instance.this.public_ip
      user        = "ubuntu"
      private_key = file(var.ssh_private_key_path)
    }
  }
}
