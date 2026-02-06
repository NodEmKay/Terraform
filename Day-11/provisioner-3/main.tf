resource "null_resource" "local_exec_example" {
  provisioner "local-exec" {
    command = "echo Hello from local-exec! > local-exec-output.txt"
  }
}
