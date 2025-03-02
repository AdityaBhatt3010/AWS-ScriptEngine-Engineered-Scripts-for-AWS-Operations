# PowerShell Script for AWS EC2 Operations

# Display menu options
Write-Output "Select an action to perform with your EC2 instances:"
Write-Output "1. Start an EC2 instance"
Write-Output "2. Stop an EC2 instance"
Write-Output "3. Terminate an EC2 instance"
Write-Output "4. Create a new EC2 instance"
Write-Output "5. List all key pairs"
Write-Output "6. Create a new key pair"
Write-Output "7. List all security groups"
Write-Output "8. List all EC2 instances"
Write-Output "9. List running EC2 instances"

$choice = Read-Host "Enter your choice (1-9)"

# Validate user input
if ($choice -lt 1 -or $choice -gt 9) 
{
    Write-Output "Invalid choice. Please select a valid option (1-9)."
    exit 1
}

switch ($choice) 
{
    1 
    {
        $INSTANCE_ID = Read-Host "Enter the EC2 instance ID to start"
        aws ec2 start-instances --instance-ids "$INSTANCE_ID"
    }
    2 
    {
        $INSTANCE_ID = Read-Host "Enter the EC2 instance ID to stop"
        aws ec2 stop-instances --instance-ids "$INSTANCE_ID"
    }
    3 
    {
        $INSTANCE_ID = Read-Host "Enter the EC2 instance ID to terminate"
        aws ec2 terminate-instances --instance-ids "$INSTANCE_ID"
    }
    4 
    {
        $AMI_ID = Read-Host "Enter the AMI ID"
        $INSTANCE_TYPE = Read-Host "Enter the instance type (e.g., t2.micro)"
        $KEY_NAME = Read-Host "Enter the key pair name"
        $SECURITY_GROUP = Read-Host "Enter the security group ID"
        aws ec2 run-instances --image-id "$AMI_ID" --instance-type "$INSTANCE_TYPE" --key-name "$KEY_NAME" --security-group-ids "$SECURITY_GROUP" --count 1
    }
    5 
    {
        aws ec2 describe-key-pairs
    }
    6 
    {
        $KEY_NAME = Read-Host "Enter the name for the new key pair"
        aws ec2 create-key-pair --key-name "$KEY_NAME" --output text
    }
    7 
    {
        aws ec2 describe-security-groups
    }
    8 
    {
        aws ec2 describe-instances
    }
    9 
    {
        aws ec2 describe-instances --filters Name=instance-state-name,Values=running
    }
}
