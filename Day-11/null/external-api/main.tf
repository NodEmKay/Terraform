resource "null_resource" "external_api_example" {
  provisioner "local-exec" {
    command = "curl -lsX POST https://httpbin.org/post -d '{\"event\":\"terraform_apply\"}' > external-api-response.txt"
  }
}
