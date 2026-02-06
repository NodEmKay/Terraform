# Conditional EC2 Instance Creation with Terraform

This example demonstrates how to use the `count` meta-argument to conditionally create an AWS EC2 instance based on a variable.

## How it works
- The `create_instance` variable controls whether the EC2 instance is created.
- If `create_instance` is `true`, one instance is created.
- If `create_instance` is `false`, no instance is created.

## Key Files
- `main.tf`: Contains the resource definition and variable.
- `provider.tf`: AWS provider configuration.

## Usage
1. Initialize Terraform:
   ```bash
   terraform init
   ```
2. Plan and apply (default creates the instance):
   ```bash
   terraform plan
   terraform apply
   ```
3. To skip creation, set the variable to false:
   ```bash
   terraform apply -var="create_instance=false"
   ```

## Example Resource
```hcl
resource "aws_instance" "conditional" {
  count         = var.create_instance ? 1 : 0
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  tags = {
    Name = "conditional-instance"
  }
}
```

## Clean Up
To destroy resources:
```bash
terraform destroy
```

---
For more count examples, see sibling directories in Day-11/count.
