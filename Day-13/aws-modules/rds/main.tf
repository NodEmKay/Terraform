# RDS Module
resource "aws_db_instance" "this" {
  allocated_storage    = var.allocated_storage
  engine               = var.engine
  instance_class       = var.instance_class
  identifier           = "rds-${var.tags["Environment"]}"
  db_name              = var.db_name
  username             = var.username
  password             = var.password
  skip_final_snapshot  = true
  vpc_security_group_ids = var.security_group_ids
  db_subnet_group_name = var.db_subnet_group_name
  tags = var.tags
}
