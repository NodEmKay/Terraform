provider "aws" {
  region = var.aws_region
}

# EC2 Instances
resource "aws_instance" "server" {
  count         = length(var.instance_names) # Better than hardcoding '3'
  ami           = var.ami
  instance_type = var.instance_type
  # key_name = "dummy"

  tags = {
    #Name = "SRV105"
    Name = var.instance_names[count.index]
  }
}
# S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.s3_bucket_name

  tags = {
    Name = var.s3_bucket_name
  }

}
  
# ONLY Versioning Resource
#resource "aws_s3_bucket_versioning" "my_bucket_versioning" {
 # bucket = aws_s3_bucket.my_bucket.id
  
  #versioning_configuration {
   # status = "Enabled"
  #}
#}