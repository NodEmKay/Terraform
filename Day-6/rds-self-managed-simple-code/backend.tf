terraform {
  backend "s3" {
    bucket = "node-emkaye01"
    key = "terraform.state"
    region = "us-east-1"
    # Enable S3 native locking
    use_lockfile = true
    #The dynamo DB arguement is no longer needed
    dynamodb_table = "use_dydb_state_file"
}
}