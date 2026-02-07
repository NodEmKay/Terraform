resource "aws_instance" "taint_demo" {
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = "TaintDemo"
  }
}

#output "instance_id" {
 #value = aws_instance.taint_demo.id
#}
