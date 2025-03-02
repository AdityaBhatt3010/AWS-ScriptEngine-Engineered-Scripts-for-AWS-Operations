#!/bin/bash

# Function to display menu options
echo "Select an action to perform with your S3 bucket:"
echo "1. Get S3 bucket region"
echo "2. Upload a file to S3 bucket"
echo "3. Download a file from S3 bucket"
echo "4. Remove a file from S3 bucket"
echo "5. Create a new S3 bucket"
echo "6. List all S3 buckets"
echo "7. Get bucket location"
echo "8. Check bucket versioning"
echo "9. Enable bucket versioning"
echo "10. Retrieve object metadata"
echo "Enter your choice (1-10): "
read -r choice

# Validate user input
if ! [[ "$choice" =~ ^[1-9]$|^10$ ]]; then
    echo "Invalid choice. Please select a valid option (1-10)."
    exit 1
fi

case $choice in
    1)
        aws configure get region
        ;;
    2)
        echo "Enter the file name to upload: "
        read -r FILE_NAME
        echo "Enter the S3 bucket name: "
        read -r BUCKET_NAME
        if [ ! -f "$FILE_NAME" ]; then
            echo "Error: File '$FILE_NAME' does not exist."
            exit 1
        fi
        aws s3 cp "$FILE_NAME" "s3://$BUCKET_NAME/$FILE_NAME"
        ;;
    3)
        echo "Enter the file name to download: "
        read -r FILE_NAME
        echo "Enter the S3 bucket name: "
        read -r BUCKET_NAME
        if ! aws s3 ls "s3://$BUCKET_NAME/$FILE_NAME" > /dev/null 2>&1; then
            echo "Error: File '$FILE_NAME' does not exist in bucket '$BUCKET_NAME'."
            exit 1
        fi
        aws s3 cp "s3://$BUCKET_NAME/$FILE_NAME" "$FILE_NAME"
        ;;
    4)
        echo "Enter the file name to remove: "
        read -r FILE_NAME
        echo "Enter the S3 bucket name: "
        read -r BUCKET_NAME
        aws s3 rm "s3://$BUCKET_NAME/$FILE_NAME"
        ;;
    5)
        echo "Enter the new S3 bucket name: "
        read -r BUCKET_NAME
        echo "Enter the AWS region (e.g., ap-south-1): "
        read -r REGION
        if aws s3api head-bucket --bucket "$BUCKET_NAME" 2>/dev/null; then
            echo "Error: Bucket name '$BUCKET_NAME' is already taken or invalid."
            exit 1
        fi
        aws s3 mb "s3://$BUCKET_NAME" --region "$REGION"
        ;;
    6)
        aws s3api list-buckets --query 'Buckets[].Name'
        ;;
    7)
        echo "Enter the S3 bucket name: "
        read -r BUCKET_NAME
        aws s3api get-bucket-location --bucket "$BUCKET_NAME"
        ;;
    8)
        echo "Enter the S3 bucket name: "
        read -r BUCKET_NAME
        aws s3api get-bucket-versioning --bucket "$BUCKET_NAME"
        ;;
    9)
        echo "Enter the S3 bucket name: "
        read -r BUCKET_NAME
        aws s3api put-bucket-versioning --bucket "$BUCKET_NAME" --versioning-configuration Status=Enabled
        ;;
    10)
        echo "Enter the S3 bucket name: "
        read -r BUCKET_NAME
        echo "Enter the object key (file name in S3): "
        read -r OBJECT_KEY
        aws s3api head-object --bucket "$BUCKET_NAME" --key "$OBJECT_KEY"
        ;;
esac
