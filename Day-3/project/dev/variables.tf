variable "aws_region" {}
variable "ami" {}
variable "instance_type" {}
variable "instance_names" {
    type    = list(string)
    default = ["srv101", "srv102", "srv103"]
 }
variable "s3_bucket_name" {
    type = string
}