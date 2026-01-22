module "app_storage" {
  source             = "./modules/simple_s3"
  bucket_name_prefix = "my-unique-app"
  environment        = "prod"
}

# You can use the output of the module elsewhere!
output "final_bucket_location" {
  value = module.app_storage.bucket_arn
}