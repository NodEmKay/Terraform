output "bastion_public_ip" {
  value = aws_instance.bastion_01.public_ip
}

output "private_instance_id" {
  value = aws_instance.app_01.id
}

output "vpc_id" {
  value = aws_vpc.vpc_ppa.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "nat_gateway_ip" {
  value = aws_eip.nat_eip.public_ip
}