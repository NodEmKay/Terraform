output "instance_id" {
  description = "The EC2 instance ID"
  value       = module.ec2_instance.instance_id
}

output "public_ip" {
  description = "Public IP of the instance"
  value       = module.ec2_instance.public_ip
}

output "public_dns" {
  description = "Public DNS name"
  value       = module.ec2_instance.public_dns
}
