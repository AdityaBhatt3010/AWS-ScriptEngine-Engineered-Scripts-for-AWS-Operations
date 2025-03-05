# PowerShell Script for AWS DynamoDB Operations

# Display menu options
Write-Output "Select an action to perform with your DynamoDB tables:"
Write-Output "1. List all DynamoDB tables"
Write-Output "2. Create a new DynamoDB table"
Write-Output "3. Insert an item into a DynamoDB table"
Write-Output "4. Retrieve an item from a DynamoDB table"
Write-Output "5. Query data from a DynamoDB table"
Write-Output "6. Scan data in a DynamoDB table"
Write-Output "7. Delete an item from a DynamoDB table"

$choice = Read-Host "Enter your choice (1-7)"

# Validate user input (Ensure it's a number and within range)
if ($choice -match "^[1-7]$") {
    $choice = [int]$choice
} else {
    Write-Output "Invalid choice. Please select a valid option (1-7)."
    exit 1
}

switch ($choice) {
    1 {
        aws dynamodb list-tables
    }
    2 {
        $JSON_FILE = Read-Host "Enter the JSON file path for table creation"
        $REGION = Read-Host "Enter the AWS region"
        aws dynamodb create-table --cli-input-json file://$JSON_FILE --region $REGION
    }
    3 {
        $TABLE_NAME = Read-Host "Enter the table name"
        $ITEM_JSON = Read-Host "Enter the item JSON (single-line format)"
        aws dynamodb put-item --table-name $TABLE_NAME --item "$ITEM_JSON"
    }
    4 {
        $TABLE_NAME = Read-Host "Enter the table name"
        $KEY_JSON = Read-Host "Enter the key JSON (single-line format)"
        aws dynamodb get-item --table-name $TABLE_NAME --key "$KEY_JSON"
    }
    5 {
        $TABLE_NAME = Read-Host "Enter the table name"
        $CONDITION = Read-Host "Enter the key condition expression"
        $EXPRESSION_VALUES = Read-Host "Enter the expression attribute values JSON"
        aws dynamodb query --table-name $TABLE_NAME --key-condition-expression "$CONDITION" --expression-attribute-values "$EXPRESSION_VALUES"
    }
    6 {
        $TABLE_NAME = Read-Host "Enter the table name"
        $FILTER_EXPRESSION = Read-Host "Enter the filter expression"
        $EXPRESSION_VALUES = Read-Host "Enter the expression attribute values JSON"
        aws dynamodb scan --table-name $TABLE_NAME --filter-expression "$FILTER_EXPRESSION" --expression-attribute-values "$EXPRESSION_VALUES"
    }
    7 {
        $TABLE_NAME = Read-Host "Enter the table name"
        $KEY_JSON = Read-Host "Enter the key JSON (single-line format)"
        aws dynamodb delete-item --table-name $TABLE_NAME --key "$KEY_JSON"
    }
}
