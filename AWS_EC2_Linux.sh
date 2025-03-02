#!/bin/bash

# Function to display menu options
echo "Select an action to perform with your EC2 instances:"
echo "1. Start an EC2 instance"
echo "2. Stop an EC2 instance"
echo "3. Terminate an EC2 instance"
echo "4. Create a new EC2 instance"
echo "5. List all key pairs"
echo "6. Create a new key pair"
echo "7. List all security groups"
echo "8. List all EC2 instances"
echo "9. List running EC2 instances"
echo "Enter your choice (1-9): "
read -r choice

# Validate user input
if ! [[ "$choice" =~ ^[1-9]$ ]]; then
    echo "Invalid choice. Please select a valid option (1-9)."
    exit 1
fi

case $choice in
    1)
        echo "Enter the EC2 instance ID to start: "
        read -r INSTANCE_ID
        aws ec2 start-instances --instance-ids "$INSTANCE_ID"
        ;;
    2)
        echo "Enter the EC2 instance ID to stop: "
        read -r INSTANCE_ID
        aws ec2 stop-instances --instance-ids "$INSTANCE_ID"
        ;;
    3)
        echo "Enter the EC2 instance ID to terminate: "
        read -r INSTANCE_ID
        aws ec2 terminate-instances --instance-ids "$INSTANCE_ID"
        ;;
    4)
        echo "Enter the AMI ID: "
        read -r AMI_ID
        echo "Enter the instance type (e.g., t2.micro): "
        read -r INSTANCE_TYPE
        echo "Enter the key pair name: "
        read -r KEY_NAME
        echo "Enter the security group ID: "
        read -r SECURITY_GROUP
        aws ec2 run-instances --image-id "$AMI_ID" --instance-type "$INSTANCE_TYPE" --key-name "$KEY_NAME" --security-group-ids "$SECURITY_GROUP" --count 1
        ;;
    5)
        aws ec2 describe-key-pairs
        ;;
    6)
        echo "Enter the name for the new key pair: "
        read -r KEY_NAME
        aws ec2 create-key-pair --key-name "$KEY_NAME" --output text
        ;;
    7)
        aws ec2 describe-security-groups
        ;;
    8)
        aws ec2 describe-instances
        ;;
    9)
        aws ec2 describe-instances --filters Name=instance-state-name,Values=running
        ;;
esac
