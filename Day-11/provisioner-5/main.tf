resource "null_resource" "timestamp_test" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "bash -c 'echo The current timestamp is $(date) > timestamp-test.txt'"
  }
}
