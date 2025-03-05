# PowerShell Script for AWS EC2 Operations

# Display menu options
Write-Output "`nSelect an action to perform with your EC2 instances:"
Write-Output "1. Start an EC2 instance"
Write-Output "2. Stop an EC2 instance"
Write-Output "3. Terminate an EC2 instance"
Write-Output "4. Create a new EC2 instance"
Write-Output "5. List all key pairs"
Write-Output "6. Create a new key pair"
Write-Output "7. List all security groups"
Write-Output "8. List all EC2 instances"
Write-Output "9. List running EC2 instances"

# Get user choice
$choice = Read-Host "Enter your choice (1-9)"

# Validate user input
if ($choice -match "^[1-9]$") {
    switch ($choice) {
        "1" {
            $INSTANCE_ID = Read-Host "Enter the EC2 instance ID to start"
            aws ec2 start-instances --instance-ids "$INSTANCE_ID"
            Write-Output "Instance $INSTANCE_ID is starting..."
        }
        "2" {
            $INSTANCE_ID = Read-Host "Enter the EC2 instance ID to stop"
            aws ec2 stop-instances --instance-ids "$INSTANCE_ID"
            Write-Output "Instance $INSTANCE_ID is stopping..."
        }
        "3" {
            $INSTANCE_ID = Read-Host "Enter the EC2 instance ID to terminate"
            aws ec2 terminate-instances --instance-ids "$INSTANCE_ID"
            Write-Output "Instance $INSTANCE_ID is being terminated..."
        }
        "4" {
            $AMI_ID = Read-Host "Enter the AMI ID"
            $INSTANCE_TYPE = Read-Host "Enter the instance type (e.g., t2.micro)"
            $KEY_NAME = Read-Host "Enter the key pair name"
            $SECURITY_GROUP = Read-Host "Enter the security group ID"
            aws ec2 run-instances --image-id "$AMI_ID" --instance-type "$INSTANCE_TYPE" --key-name "$KEY_NAME" --security-group-ids "$SECURITY_GROUP" --count 1
            Write-Output "EC2 instance is being created..."
        }
        "5" {
            Write-Output "Listing all key pairs..."
            aws ec2 describe-key-pairs
        }
        "6" {
            $KEY_NAME = Read-Host "Enter the name for the new key pair"
            aws ec2 create-key-pair --key-name "$KEY_NAME" --output text
            Write-Output "Key pair '$KEY_NAME' created successfully."
        }
        "7" {
            Write-Output "Listing all security groups..."
            aws ec2 describe-security-groups
        }
        "8" {
            Write-Output "Listing all EC2 instances..."
            aws ec2 describe-instances
        }
        "9" {
            Write-Output "Listing running EC2 instances..."
            aws ec2 describe-instances --filters Name=instance-state-name,Values=running
        }
    }
} else {
    Write-Output "Invalid choice. Please enter a number between 1 and 9."
}
