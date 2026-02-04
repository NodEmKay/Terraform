module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  for_each = toset(["one", "two", "three"])

  name = "instance-${each.key}"

  instance_type = "t3.micro"
  key_name      = "ec2-user1"
  monitoring    = true
  subnet_id     = "subnet-0ed1760fa5193ded9"

  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
}