resource "null_resource" "force_run" {
  triggers = {
    always_run = timestamp() # Forces rerun every time
  }

  provisioner "local-exec" {
    command = "echo This runs every apply at $(date) > always_run.txt"
  }
}
