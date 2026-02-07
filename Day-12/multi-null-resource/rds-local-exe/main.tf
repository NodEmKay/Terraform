resource "aws_db_instance" "example" {
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.mysql8.0"
  publicly_accessible    = true
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds_public_sg.id]
}

resource "aws_security_group" "rds_public_sg" {
  name        = "rds-public-sg"
  description = "Allow MySQL access from anywhere (for demo only)"

  ingress {
    from_port   = 3306
    to_port     = 3306
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

resource "null_resource" "init_db" {
  provisioner "local-exec" {
    command = "mysql --host=${aws_db_instance.example.address} --port=3306 --user=${var.db_username} --password=${var.db_password} < ${path.module}/init.sql"
    environment = {
      MYSQL_PWD = var.db_password
    }
  }
  triggers = {
    always_run = timestamp()
  }
  depends_on = [aws_db_instance.example]
}
