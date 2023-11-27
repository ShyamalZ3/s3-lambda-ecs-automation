import json
import boto3
import os


def lambda_handler(event, context):
    # Get the SNS message details
    bucket_name = str(event['Records'][0]['s3']['bucket']['name'])
    path = str(event['Records'][0]['s3']['object']['key'])
    print(bucket_name)
    print(path)
    # Environment Variables
    TASK_NAME = os.environ.get("task_name")
    CLUSTER_NAME = os.environ.get("cluster_name")
    CONTAINER_NAME = os.environ.get("container_name")
    
    ttl_threshold = ""
    
    # Create an ECS client
    ecs = boto3.client('ecs')
    
    # Set ECS Task Environment Variables
    environment_variables = [
        {
            "name": "bucket_name",
            "value": bucket_name
        },
        {
            "name": "path",
            "value": path
        }
    ]
    
    # Get Subnets
    subnet_list = str(os.environ.get("subnets")).split(",")
    sg_list = str(os.environ.get("security_groups")).split(",")
    
    try:
        response = ecs.run_task(
            cluster=CLUSTER_NAME,
            taskDefinition=TASK_NAME,
            launchType="FARGATE",
            overrides={
                'containerOverrides': [
                    {
                        "name": CONTAINER_NAME,
                        'environment': environment_variables
                    }
                ]
            },
            count=1,
            networkConfiguration={
                'awsvpcConfiguration': {
                    'subnets': subnet_list,
                    'securityGroups': sg_list,
                    'assignPublicIp': "ENABLED"
                }
            })
    except Exception as e:
        raise e
    else:
        print(response)

