output "webserver_1_public_ip" {
  description = "Public IP of webserver 1"
  value       = module.webserver_1.public_ip
}

output "webserver_2_public_ip" {
  description = "Public IP of webserver 2"
  value       = module.webserver_2.public_ip
}
