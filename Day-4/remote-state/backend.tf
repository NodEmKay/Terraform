terraform {
  backend "s3" {
    bucket = "node-s3-bucket001"
    key = "terraform.state"
    region = "us-east-1"
}

}