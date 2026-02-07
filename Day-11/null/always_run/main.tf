resource "null_resource" "always_run_example" {
  triggers = {
    always_run = timestamp() # Forces rerun every apply
  }

  provisioner "local-exec" {
    command = "bash -c 'echo always_run triggered at $(date) >> always_run.txt'"
  }
}
