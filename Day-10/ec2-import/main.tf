resource "aws_instance" "test1" {
  ami                    = "ami-0532be01f26a3de55"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-09a08d7d80e3703b2"
  vpc_security_group_ids = ["sg-0358b2de476676075"]
  associate_public_ip_address = true
  availability_zone      = "us-east-1d"
  tags = {
    Name = "test1"
  }
  root_block_device {
    volume_type           = "gp3"
    volume_size           = 8
    iops                  = 3000
    throughput            = 125
    delete_on_termination = true
    encrypted             = false
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
    instance_metadata_tags      = "disabled"
  }
}

resource "aws_instance" "test2" {
  ami                    = "ami-0532be01f26a3de55"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-09a08d7d80e3703b2"
  vpc_security_group_ids = ["sg-04522f199a07a7130"]
  associate_public_ip_address = true
  availability_zone      = "us-east-1d"
  tags = {
    Name = "test2"
  }
  root_block_device {
    volume_type           = "gp3"
    volume_size           = 8
    iops                  = 3000
    throughput            = 125
    delete_on_termination = true
    encrypted             = false
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
    instance_metadata_tags      = "disabled"
  }
}

resource "aws_s3_bucket" "mybucket-01-s3-bucket-test" {
  bucket = "mybucket-01-s3-bucket-test"
}