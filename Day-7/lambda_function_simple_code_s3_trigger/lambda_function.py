import json

def lambda_handler(event, context):
    print("S3 Event Received: " + json.dumps(event))
    return {"status": "success"}