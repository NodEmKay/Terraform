variable "bucket_name_prefix" {
  description = "The beginning of the bucket name"
  type        = string
}

variable "environment" {
  description = "dev, staging, or prod"
  type        = string
  default     = "dev"
}