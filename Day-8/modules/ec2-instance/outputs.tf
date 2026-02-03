output "instance_id" {
  description = "The EC2 instance ID"
  value       = aws_instance.example.id
}

output "public_ip" {
  description = "Public IP of the instance"
  value       = aws_instance.example.public_ip
}

output "public_dns" {
  description = "Public DNS name"
  value       = aws_instance.example.public_dns
}
