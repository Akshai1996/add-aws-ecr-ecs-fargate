#!/bin/bash
set -e

echo "Starting CodeDeploy agent deployment"
aws --version

echo "Constructing deployment command..."
COMMAND=$(cat <<EOT
aws deploy create-deployment \
    --application-name "app-6" \
    --deployment-config-name CodeDeployDefault.ECSAllAtOnce \
    --deployment-group-name "app-6-deploy-group" \
    --revision '{"revisionType": "AppSpecContent", "appSpecContent": {"content": "{\"Resources\":[{\"TargetService\":{\"Properties\":{\"LoadBalancerInfo\":{\"ContainerName\":\"first\",\"ContainerPort\":8080},\"TaskDefinition\":\"arn:aws:ecs:us-east-1:008971661427:task-definition/app-6:7\"},\"Type\":\"AWS::ECS::Service\"}}],\"version\":\"0.0\"}", "sha256":"41de9b24b630a9ad6c89d4f678e1f6c180d29657b7f5658f20d69bd3f2d2b213"}}' \
    --description "Deployment from Terraform" \
    --output json
EOT
)

echo "Command to be executed:"
echo "$COMMAND"

echo "Executing deployment command..."
DEPLOYMENT_INFO=$(eval "$COMMAND")
COMMAND_EXIT_CODE=$?

echo "Command exit code: $COMMAND_EXIT_CODE"
echo "Raw output:"
echo "$DEPLOYMENT_INFO"

if [ $COMMAND_EXIT_CODE -ne 0 ]; then
    echo "Error: AWS CLI command failed"
    exit $COMMAND_EXIT_CODE
fi

echo "Parsing deployment info..."
if ! DEPLOYMENT_ID=$(echo "$DEPLOYMENT_INFO" | jq -r '.deploymentId'); then
    echo "Error: Failed to parse deployment ID from output"
    exit 1
fi

if [ "$DEPLOYMENT_ID" == "null" ] || [ -z "$DEPLOYMENT_ID" ]; then
    echo "Error: Deployment ID is null or empty"
    exit 1
fi

echo "Deployment ID: $DEPLOYMENT_ID"

echo "Deployment created successfully"
