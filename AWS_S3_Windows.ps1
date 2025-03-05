# PowerShell Script for AWS S3 Operations

# Display menu options
Write-Output "Select an action to perform with your S3 bucket:"
Write-Output "1. Get S3 bucket region"
Write-Output "2. Upload a file to S3 bucket"
Write-Output "3. Download a file from S3 bucket"
Write-Output "4. Remove a file from S3 bucket"
Write-Output "5. Create a new S3 bucket"
Write-Output "6. List all S3 buckets"
Write-Output "7. Get bucket location"
Write-Output "8. Check bucket versioning"
Write-Output "9. Enable bucket versioning"
Write-Output "10. Retrieve object metadata"

$choice = Read-Host "Enter your choice (1-10)"

# Validate user input
if ($choice -match '^\d+$' -and [int]$choice -ge 1 -and [int]$choice -le 10) {
    $choice = [int]$choice
} else {
    Write-Output "Invalid choice. Please select a valid option (1-10)."
    exit 1
}

switch ($choice) {
    1 {
        aws configure get region
    }
    2 {
        $FILE_NAME = Read-Host "Enter the file name to upload"
        $BUCKET_NAME = Read-Host "Enter the S3 bucket name"
        if (-Not (Test-Path $FILE_NAME)) {
            Write-Output "Error: File '$FILE_NAME' does not exist."
            exit 1
        }
        aws s3 cp "$FILE_NAME" "s3://$BUCKET_NAME/$FILE_NAME"
    }
    3 {
        $FILE_NAME = Read-Host "Enter the file name to download"
        $BUCKET_NAME = Read-Host "Enter the S3 bucket name"
        $fileExists = aws s3 ls "s3://$BUCKET_NAME/$FILE_NAME"
        if (-Not $fileExists) {
            Write-Output "Error: File '$FILE_NAME' does not exist in bucket '$BUCKET_NAME'."
            exit 1
        }
        aws s3 cp "s3://$BUCKET_NAME/$FILE_NAME" "$FILE_NAME"
    }
    4 {
        $FILE_NAME = Read-Host "Enter the file name to remove"
        $BUCKET_NAME = Read-Host "Enter the S3 bucket name"
        aws s3 rm "s3://$BUCKET_NAME/$FILE_NAME"
    }
    5 {
        $BUCKET_NAME = Read-Host "Enter the new S3 bucket name"
        $REGION = Read-Host "Enter the AWS region (e.g., ap-south-1)"
        $bucketExists = aws s3api head-bucket --bucket "$BUCKET_NAME" 2>$null
        if ($bucketExists) {
            Write-Output "Error: Bucket name '$BUCKET_NAME' is already taken or invalid."
            exit 1
        }
        aws s3 mb "s3://$BUCKET_NAME" --region "$REGION"
    }
    6 {
        aws s3api list-buckets --query 'Buckets[].Name'
    }
    7 {
        $BUCKET_NAME = Read-Host "Enter the S3 bucket name"
        aws s3api get-bucket-location --bucket "$BUCKET_NAME"
    }
    8 {
        $BUCKET_NAME = Read-Host "Enter the S3 bucket name"
        aws s3api get-bucket-versioning --bucket "$BUCKET_NAME"
    }
    9 {
        $BUCKET_NAME = Read-Host "Enter the S3 bucket name"
        aws s3api put-bucket-versioning --bucket "$BUCKET_NAME" --versioning-configuration Status=Enabled
    }
    10 {
        $BUCKET_NAME = Read-Host "Enter the S3 bucket name"
        $OBJECT_KEY = Read-Host "Enter the object key (file name in S3)"
        aws s3api head-object --bucket "$BUCKET_NAME" --key "$OBJECT_KEY"
    }
}
