terraform {
  backend "s3" {
    bucket = "node-s3-bucket0011"
    key = "terraform.state"
    region = "us-east-1"
}

}