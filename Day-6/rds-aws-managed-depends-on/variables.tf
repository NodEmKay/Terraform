variable "db_identifier" {
  type        = string
  description = "The name of the RDS instance"
}

variable "db_name" {
  type        = string
  description = "The name of the database to create"
}

variable "db_username" {
  type        = string
  description = "Master username"
}

variable "db_instance_class" {
  type        = string
  description = "Instance type (e.g. db.t3.medium)"
  default     = "db.t3.medium"
}