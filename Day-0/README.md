Terraform is an open-source tool that uses code to automatically create and manage cloud infrastructure like servers and networks. It allows you to define your entire setup in configuration files, ensuring your environment is consistent, repeatable, and easy to version control.
Download link "https://developer.hashicorp.com/terraform/install"
Windows: Download the ZIP, extract terraform.exe, and add its folder path to your System Environment Variables (Path).
The "Big Four" Commands
terraform -v -> To check which version of Terraform
terraform init -> Initializes your directory and downloads the necessary cloud provider plugins (like AWS or Azure)
terraform plan -> Previews the changes Terraform will make to your infrastructure before actually doing them
terraform apply -> Executes the plan to create or update your infrastructure (requires a "yes" confirmation)
terraform destroy -> Safely removes all resources managed by your configuration files


