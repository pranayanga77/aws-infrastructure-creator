# AWS Infrastructure Creator

Automates:
- S3 bucket creation (dynamic naming)
- Latest Ubuntu AMI retrieval
- EC2 instance launch with tagging

Region: eu-north-1 (Stockholm)

Usage:
./create_infra.sh eu-north-1

This project automates AWS infrastructure using Bash & AWS CLI.

## Features
- Creates S3 bucket (dynamic naming)
- Fetches latest Ubuntu AMI
- Launches EC2 instance with tagging

## Region
eu-north-1 (Stockholm)

## Prerequisites
- AWS CLI configured
- IAM user with EC2 and S3 permissions

## Usage
./create_infra.sh eu-north-1

