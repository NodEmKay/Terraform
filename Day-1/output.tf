output "instance_id" {
  value = aws_instance.Ubuntu-Image.id
}

output "public_ip" {
  value = aws_instance.Ubuntu-Image.public_ip
}

output "private_ip" {
  value = aws_instance.Ubuntu-Image.private_ip
}

output "instance_arn" {
  value = aws_instance.Ubuntu-Image.arn
}

output "availability_zone" {
  value = aws_instance.Ubuntu-Image.availability_zone
}