# Add your private key path for SSH provisioners
ssh_private_key_path = "C:/Users/muthu/.ssh/keypair826.pem"
ami_id_1 = "ami-0532be01f26a3de55"
ami_id_2 = "ami-0b6c6ebed2801a5cb"

region = "us-east-1"

ssh_key_name_1 = "keypair826"
ssh_key_name_2 = "keypair826"

instance_type_1 = "t3.micro"
instance_type_2 = "t2.medium"

# Security group rules for module-2
ingress_rules = [
	{
		description = "HTTP"
		from_port   = 80
		to_port     = 80
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	},
	{
		description = "SSH"
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
]

egress_rules = [
	{
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
]

# Security group rules for module-1
ingress_rules_1 = [
	{
		description = "HTTP"
		from_port   = 80
		to_port     = 80
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	},
	{
		description = "SSH"
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
]

egress_rules_1 = [
	{
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
]