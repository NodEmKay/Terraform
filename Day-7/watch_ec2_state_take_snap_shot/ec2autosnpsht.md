# EC2 Auto-Snapshot on Termination

This project automates data protection for AWS EC2 instances. Using **Event-Driven Architecture**, it ensures that if an instance begins to shut down or terminate, a point-in-time backup (snapshot) of its EBS volumes is created immediately.

## How it Works

1. **The Trigger:** Amazon **EventBridge** monitors your EC2 instances for the `shutting-down` state.
2. **The Brain:** An **AWS Lambda** function is triggered by EventBridge. It identifies the instance ID and its attached volumes.
3. **The Action:** The Lambda function calls the EC2 API to create a snapshot of each volume and applies identifying tags.
4. **The Protection:** Instances are configured with `delete_on_termination = false` and Terraform `prevent_destroy` to ensure volumes stay alive long enough for the backup to complete.

## Architecture Components

* **3x EC2 Instances:** Sample servers used to test the automation.
* **EventBridge Rule:** The "Security Camera" watching for specific instance state changes.
* **IAM Role:** Provides the Lambda function with precise permissions (`ec2:CreateSnapshot`, `ec2:CreateTags`) to perform its duties.
* **S3 Bucket:** Included as an optional resource for log storage or file handling.

## Project Structure

```text
.
├── main.tf              # Terraform infrastructure (EC2, Lambda, EventBridge, IAM)
├── lambda_function.py   # Python logic for snapshot creation
└── README.md            # Documentation

```

## Setup & Deployment

1. **Initialize:** ```bash
terraform init
```

```


2. **Deploy:** ```bash
terraform apply
```

```


3. **Test:** * Go to the AWS Console.
* Terminate one of the `Project-Server` instances.
* Navigate to **EC2 > Snapshots** to see the automatic backup.



## ⚠️ Important Considerations

* **Permissions:** The IAM policy explicitly includes `ec2:CreateTags`. Without this, the snapshot creation will fail if the code attempts to tag the resource.
* **Race Conditions:** We trigger on `shutting-down` rather than `terminated` to ensure the EBS volumes are still attached when the Lambda runs.
* **Cleanup:** To delete the infrastructure, you must first change `prevent_destroy` to `false` in `main.tf`.
