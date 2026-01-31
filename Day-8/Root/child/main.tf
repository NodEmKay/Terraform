resource "local_file" "message" {
  filename = "${path.root}/hello_from_child.txt"
  content  = "Hello ${var.user_name}, this file was made by the Child module!"
}