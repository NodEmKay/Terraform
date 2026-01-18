terraform {
  backend "s3" {
    bucket = "node-s3-bucket001"
    key = "terraform.state"
    region = "us-east-1"
    # Enable S3 native locking
    use_lockfile = true
    #The dynamo DB arguement is no longer needed
    dynamodb_table = "db_to_monitor_tasks_and_lock_tf_state_when_required"

}
}