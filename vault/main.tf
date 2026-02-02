provider "aws" {
  region = "us-east-1"
}
terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.0"
    }
  }
}

provider "vault" {
  address = "http://13.218.224.194:8200"
}

data "vault_kv_secret_v2" "app_config" {
  mount = "secret"
  name  = "app/config"
}

output "username" {
  value = data.vault_kv_secret_v2.app_config.data["username"]
  sensitive = true
}

output "password" {
  value = data.vault_kv_secret_v2.app_config.data["password"]
  sensitive = true
}
resource "aws_db_instance" "mydb" {
  identifier           = "mydb"
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  username             = data.vault_kv_secret_v2.app_config.data["username"]
  password             = data.vault_kv_secret_v2.app_config.data["password"]
  skip_final_snapshot  = true
}
