resource "null_resource" "taint_demo_script" {
  provisioner "local-exec" {
    command = "echo 'This script runs only when the null_resource is tainted'"
  }
}

output "null_resource_id" {
  value = null_resource.always_tainted.id
}
