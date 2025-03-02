#!/bin/bash

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI not found. Installing..."
    
    # Install AWS CLI (Linux)
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    
    if [ $? -ne 0 ]; then
        echo "Failed to download AWS CLI. Check your internet connection."
        exit 1
    fi

    unzip awscliv2.zip
    sudo ./aws/install

    if [ $? -ne 0 ]; then
        echo "Failed to install AWS CLI. Please check for errors."
        exit 1
    fi

    echo "AWS CLI installed successfully."
else
    echo "AWS CLI is already installed."
fi

# Display AWS CLI version
aws --version

# Prompt user for AWS credentials
echo "Enter your AWS Access Key ID: "
read -r AWS_ACCESS_KEY_ID
echo "Enter your AWS Secret Access Key: "
read -s AWS_SECRET_ACCESS_KEY  # -s hides input for security
echo "Enter your AWS Region (e.g., us-east-1): "
read -r AWS_REGION

echo "Configuring AWS CLI..."

# Configure AWS CLI
aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID"
aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
aws configure set region "$AWS_REGION"

# Verify configuration
echo "AWS CLI configured successfully. Verifying credentials..."
aws sts get-caller-identity

if [ $? -eq 0 ]; then
    echo "AWS CLI setup completed successfully!"
else
    echo "Failed to configure AWS CLI. Please check your credentials and try again."
fi
