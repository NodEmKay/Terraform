# RDS with Remote Exec Initialization (EC2)

This example creates a MySQL RDS instance and an EC2 instance. The EC2 instance connects to the RDS and initializes a dummy database using a remote-exec provisioner.

## Features
- Creates a MySQL RDS instance (publicly accessible)
- Creates an EC2 instance (Amazon Linux 2)
- Installs MySQL client on EC2
- Copies and runs `init.sql` from EC2 to initialize the database/table
- Outputs the RDS endpoint and EC2 public IP

## Prerequisites
- AWS account and credentials configured
- Terraform installed
- An AWS EC2 Key Pair (update `key_name` and `private_key_path`)

## Usage Steps
1. Update variables in `terraform.tfvars` as needed:
   - `aws_region`, `db_name`, `db_username`, `db_password`, `ec2_ami`, `ec2_instance_type`, `key_name`, `private_key_path`
2. Run `terraform init`
3. Run `terraform apply` and confirm
4. Wait for Terraform to finish. The EC2 instance will initialize the RDS database.
5. Use the EC2 public IP (output) to SSH and verify, or connect to RDS as before.

## Important Note

> ⚠️ **IMPORTANT:**
>
> Terraform may destroy and recreate the EC2 instance on each apply if:
> - You change immutable arguments (AMI, instance_type, key_name, etc.)
> - Provisioners use triggers that always change (e.g., `timestamp()` or file hashes)
> - The resource depends on other resources that are replaced
> - The SSH key or `private_key_path` changes
>
> **To avoid unnecessary recreation:**
> - Do not use always-changing triggers in provisioners
> - Keep configuration stable between applies
> - Only change variables or resources when you intend to replace the instance

## Verification Steps
1. SSH to the EC2 instance:
   ```
   ssh -i <private_key_path> ec2-user@<ec2_public_ip>
   ```
2. Connect to the RDS instance from EC2:
   ```
   mysql -h <rds_endpoint> -P 3306 -u admin -p
   ```
   (Use the password from your variables.)
3. Run SQL commands to verify:
   - `SHOW DATABASES;`
   - `USE dummydb;`
   - `SHOW TABLES;`
   - `SELECT * FROM test_table;`

## Post-Deployment Verification

After running `terraform apply`, verify the deployment as follows:

1. Get the RDS endpoint and EC2 public IP from the Terraform output.
2. SSH into the EC2 instance:
   ```
   ssh -i C:/Users/muthu/.ssh/key101.pem ec2-user@<ec2_public_ip>
   ```
3. On the EC2 instance, connect to the RDS database:
   ```
   mysql -h <rds_endpoint> -P 3306 -u admin -p
   ```
   (Enter the password: ChangeMe123!)
4. Run these SQL commands to verify:
   ```
   SHOW DATABASES;
   USE remoteexe;
   SHOW TABLES;
   SELECT * FROM test_table;
   ```
5. You should see the `remoteexe` database, `test_table`, and the example row.

If all these checks succeed, your deployment and automation are working as intended!

## Security Warning
**This example exposes the database and EC2 to the public internet for demonstration purposes. Do NOT use this configuration in production.**

## Files
- `main.tf`: RDS, EC2, security groups, and remote-exec for DB init
- `variables.tf`: Input variables
- `init.sql`: SQL script to initialize the database
- `outputs.tf`: Outputs the RDS endpoint and EC2 public IP
- `provider.tf`: AWS provider config
