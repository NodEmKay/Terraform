resource "null_resource" "file_trigger_example" {
  triggers = {
    file_hash = filebase64sha256("somefile.txt")
  }

  provisioner "local-exec" {
    command = "bash -c 'echo File changed at $(date) >> file-trigger.txt'"
  }
}
