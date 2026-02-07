# RDS with Local Exec Initialization

This example creates a MySQL RDS instance with public access and uses a local-exec provisioner to connect and initialize a dummy database using an SQL file.

## Features
- Creates a MySQL RDS instance (publicly accessible)
- Security group allows MySQL access from anywhere (for demo only)
- Uses a local-exec provisioner to run `init.sql` and create a dummy database/table
- Outputs the RDS endpoint

## Prerequisites
- AWS account and credentials configured
- Terraform installed
- MySQL client (`mysql` command) installed on your machine

## Usage Steps
1. **Clone or copy this directory.**
2. **Update variables in `terraform.tfvars` as needed:**
   - `aws_region`: AWS region (default: us-east-1)
   - `db_name`: Database name (default: dummydb)
   - `db_username`: Master username (default: admin)
   - `db_password`: Master password (default: ChangeMe123!)
3. **Initialize Terraform:**
   ```
   terraform init
   ```
4. **Apply the configuration:**
   ```
   terraform apply
   ```
   - Review the plan and type `yes` to confirm.
5. **Wait for Terraform to finish.**
   - The RDS instance will be created and initialized with the SQL script.
   - The RDS endpoint will be shown in the output.

## Verification Steps
1. **Get the RDS endpoint from Terraform output.**
2. **Connect to the RDS instance using the MySQL client:**
   ```
   mysql -h <rds_endpoint> -P 3306 -u admin -p
   ```
   - Replace `<rds_endpoint>` with the value from the output.
   - Enter the password from `terraform.tfvars` when prompted.
3. **Run the following SQL commands to verify:**
   - Show all databases:
     ```
     SHOW DATABASES;
     ```
     - You should see `dummydb` in the list.
   - Use the dummy database:
     ```
     USE dummydb;
     ```
   - Show all tables:
     ```
     SHOW TABLES;
     ```
     - You should see `test_table`.
   - View the contents of the table:
     ```
     SELECT * FROM test_table;
     ```
     - You should see:
       | id | name        |
       |----|-------------|
       |  1 | example row |

## Security Warning
**This example exposes the database to the public internet for demonstration purposes. Do NOT use this configuration in production.**

## Files
- `main.tf`: RDS, security group, and null_resource for DB init
- `variables.tf`: Input variables
- `init.sql`: SQL script to initialize the database
- `outputs.tf`: Outputs the RDS endpoint
- `provider.tf`: AWS provider config
- `terraform.tfvars`: Variable values
