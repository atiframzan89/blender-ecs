import json
import boto3

def lambda_handler(event, context):
    client = boto3.client('ecs')
    response = client.run_task(
    cluster='blender-ecs',
    taskDefinition='blender-app',
    count=1,
    launchType='FARGATE',
    networkConfiguration={
                    'awsvpcConfiguration': {
                        'subnets': [
                            'subnet-0f959d59d03889bd1',
                            'subnet-060748eefef850568',
                            'subnet-053d7bf73d44c94b4',
                            'subnet-05de0c4d2c932daf4',
                            'subnet-0cd9f6327c727526e',
                            'subnet-09b00b156135caf9a'
                        ],
                        'assignPublicIp': 'ENABLED',
                        'securityGroups': ["sg-026370cccace422d5"]
                    }
                },
    )
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
