resource "null_resource" "local_exec_example" {
  provisioner "local-exec" {
    command = "bash -c 'echo Local-exec1 example at $(date) > local-exec.txt'"
  }
  triggers = {
    always_run = timestamp()
  }
}
