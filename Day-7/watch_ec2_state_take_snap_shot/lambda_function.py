import boto3
import json

ec2 = boto3.client('ec2')

def lambda_handler(event, context):
    # Log the incoming event for debugging in CloudWatch
    print(f"Event received: {json.dumps(event)}")
    
    instance_id = event['detail']['instance-id']
    print(f"Instance {instance_id} is shutting down. Securing data...")

    # Find volumes currently attached to the instance
    try:
        volumes = ec2.describe_volumes(
            Filters=[{'Name': 'attachment.instance-id', 'Values': [instance_id]}]
        )

        for vol in volumes['Volumes']:
            vol_id = vol['VolumeId']
            # Create snapshot with a clear description
            ec2.create_snapshot(
                VolumeId=vol_id,
                Description=f"Pre-termination backup for {instance_id} (Vol: {vol_id})",
                TagSpecifications=[{
                    'ResourceType': 'snapshot',
                    'Tags': [{'Key': 'CreatedBy', 'Value': 'TerminationLambda'}]
                }]
            )
            print(f"Snapshot initiated for volume: {vol_id}")
            
    except Exception as e:
        print(f"Error processing snapshots for {instance_id}: {str(e)}")
        raise e

    return {"status": "Snapshot tasks initiated"}