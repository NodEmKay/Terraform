module "greeting_machine" {
  source    = "./Child" # Use ./ because Child is now INSIDE this folder
  user_name = "Terraform Learner"
}