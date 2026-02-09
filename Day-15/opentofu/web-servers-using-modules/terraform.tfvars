# terraform.tfvars for new-modular-project
vpc_cidr      = "192.168.5.0/24"
vpc_name      = "custom-vpc"
subnet_a_cidr = "192.168.5.0/25"
subnet_b_cidr = "192.168.5.128/25"
subnet_a_name = "public-subnet"
subnet_b_name = "public-subnet-b"
az_a          = "us-east-1a"
az_b          = "us-east-1b"
igw_name      = "custom-igw"
rt_name       = "public-rt"
sg_name       = "web-sg"
ec2_name      = "web-server"
ami_id        = "ami-0532be01f26a3de55"
instance_type = "t3.micro"
key_name      = "web-key"
user_data     = <<-EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl enable httpd
systemctl start httpd
echo "Hello from $(hostname)" > /var/www/html/index.html
EOF
lb_name       = "web-lb"
tg_name       = "web-tg"
