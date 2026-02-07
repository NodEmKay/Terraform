output "rds_endpoint" {
  value = aws_db_instance.example.address
}

output "ec2_public_ip" {
  value = aws_instance.mysql_client.public_ip
}
