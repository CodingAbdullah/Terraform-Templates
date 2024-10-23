#!/bin/bash

# Prompt for Template Deploy Number
echo "Enter a number between 1-50 for the template to deploy:"
read number

# Validate if the number was correct using regex
if ! [[ "$number" =~ ^[1-9][0-9]?$|^50$ ]]; then
    echo "Invalid input. Please enter a number between 1 and 50."
    exit 1
fi

# Prompt for AWS credentials
echo "Enter your AWS Access Key ID:"
read -s aws_access_key_id

echo "Enter your AWS Secret Access Key:"
read -s aws_secret_access_key

# Set environment variables
export AWS_ACCESS_KEY_ID=$aws_access_key_id
export AWS_SECRET_ACCESS_KEY=$aws_secret_access_key

# Prompt for other inputs
echo "Enter AWS region where you want to deploy:"
read region

echo "Enter ID for Amazon Machine Image for EC2:"
read ami_id

# Change directory to the appropriate template directory
# Check if number entered is less than 10 to valid directory request
if [ "$number" -lt 10 ]; then
    cd "template0${number}*" || exit
else 
    cd "template${number}*" || exit
fi 

# Create terraform.tfvars file 
# Import region and Amazon Machine Image ID to file
echo "region = \"$region\"" > terraform.tfvars
echo "ami_id = \"$ami_id\"" >> terraform.tfvars

# Initialize Terraform configuration
# Setup the infrastructure to deployed using Terraform plan
# Finally, apply changes to Terraform infrastructure
terraform init
terraform plan
terraform apply