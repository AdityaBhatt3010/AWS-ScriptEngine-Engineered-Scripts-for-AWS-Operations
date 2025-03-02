#!/bin/bash

# Function to display menu options
echo "Select an action to perform with your DynamoDB tables:"
echo "1. List all DynamoDB tables"
echo "2. Create a new DynamoDB table"
echo "3. Insert an item into a DynamoDB table"
echo "4. Retrieve an item from a DynamoDB table"
echo "5. Query data from a DynamoDB table"
echo "6. Scan data in a DynamoDB table"
echo "7. Delete an item from a DynamoDB table"
echo "Enter your choice (1-7): "
read -r choice

# Validate user input
if ! [[ "$choice" =~ ^[1-7]$ ]]; then
    echo "Invalid choice. Please select a valid option (1-7)."
    exit 1
fi

case $choice in
    1)
        aws dynamodb list-tables
        ;;
    2)
        echo "Enter the JSON file path for table creation: "
        read -r JSON_FILE
        echo "Enter the AWS region: "
        read -r REGION
        aws dynamodb create-table --cli-input-json file://$JSON_FILE --region $REGION
        ;;
    3)
        echo "Enter the table name: "
        read -r TABLE_NAME
        echo "Enter the item JSON (single-line format): "
        read -r ITEM_JSON
        aws dynamodb put-item --table-name "$TABLE_NAME" --item "$ITEM_JSON"
        ;;
    4)
        echo "Enter the table name: "
        read -r TABLE_NAME
        echo "Enter the key JSON (single-line format): "
        read -r KEY_JSON
        aws dynamodb get-item --table-name "$TABLE_NAME" --key "$KEY_JSON"
        ;;
    5)
        echo "Enter the table name: "
        read -r TABLE_NAME
        echo "Enter the key condition expression: "
        read -r CONDITION
        echo "Enter the expression attribute values JSON: "
        read -r EXPRESSION_VALUES
        aws dynamodb query --table-name "$TABLE_NAME" --key-condition-expression "$CONDITION" --expression-attribute-values "$EXPRESSION_VALUES"
        ;;
    6)
        echo "Enter the table name: "
        read -r TABLE_NAME
        echo "Enter the filter expression: "
        read -r FILTER_EXPRESSION
        echo "Enter the expression attribute values JSON: "
        read -r EXPRESSION_VALUES
        aws dynamodb scan --table-name "$TABLE_NAME" --filter-expression "$FILTER_EXPRESSION" --expression-attribute-values "$EXPRESSION_VALUES"
        ;;
    7)
        echo "Enter the table name: "
        read -r TABLE_NAME
        echo "Enter the key JSON (single-line format): "
        read -r KEY_JSON
        aws dynamodb delete-item --table-name "$TABLE_NAME" --key "$KEY_JSON"
        ;;
esac
