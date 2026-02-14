#!/bin/bash

###############################################################################
# AWS Infrastructure Creator
# Region: Europe (Stockholm) - eu-north-1
# Author: Pranay
###############################################################################

# Check if region argument is passed
if [ $# -ne 1 ]; then
    echo "Usage: ./create_infra.sh <aws_region>"
    exit 1
fi

REGION=$1
BUCKET_NAME="pranay-devops-bucket-$(date +%s)"
INSTANCE_NAME="Pranay-DevOps-EC2"

echo "--------------------------------------"
echo "Creating S3 Bucket in $REGION..."
echo "--------------------------------------"

aws s3 mb s3://$BUCKET_NAME --region $REGION

if [ $? -eq 0 ]; then
    echo "S3 Bucket Created: $BUCKET_NAME"
else
    echo "S3 Creation Failed"
    exit 1
fi

echo "--------------------------------------"
echo "Fetching Latest Ubuntu AMI..."
echo "--------------------------------------"

AMI_ID=$(aws ec2 describe-images \
    --owners 099720109477 \
    --filters "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*" \
    --query "Images | sort_by(@, &CreationDate)[-1].ImageId" \
    --region $REGION \
    --output text)

echo "Using AMI: $AMI_ID"

echo "--------------------------------------"
echo "Launching EC2 Instance..."
echo "--------------------------------------"

aws ec2 run-instances \
    --image-id $AMI_ID \
    --instance-type t3.micro \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME}]" \
    --region $REGION

if [ $? -eq 0 ]; then
    echo "EC2 Instance Launched Successfully"
else
    echo "EC2 Launch Failed"
    exit 1
fi

echo "--------------------------------------"
echo "Project Completed Successfully 🚀"
echo "--------------------------------------"
