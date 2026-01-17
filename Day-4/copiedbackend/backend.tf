terraform {
  backend "s3" {
    bucket = "node-s3-bucket0011"
    key = "terraform.state"
    region = "us-east-1"
    # Enable S3 native locking
    use_lockfile = true
    # The dynamo DB arguement is no longer needed
}

}