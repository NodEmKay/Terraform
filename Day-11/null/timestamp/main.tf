resource "null_resource" "timestamp_example" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "bash -c 'echo Timestamp: $(date) >> timestamp.txt'"
  }
}
