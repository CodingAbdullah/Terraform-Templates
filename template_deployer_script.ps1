# Prompt for Template Deploy Number
$number = Read-Host "Enter a number between 1-50 for the template to deploy"

# Validate if the number was correct using regex
if (-not ($number -match '^(?:[1-9]|[1-4][0-9]|50)$')) {
    Write-Host "Invalid input. Please enter a number between 1 and 50."
    exit 1
}

# Prompt for AWS credentials
$aws_access_key_id = Read-Host "Enter your AWS Access Key ID" -AsSecureString
$aws_secret_access_key = Read-Host "Enter your AWS Secret Access Key" -AsSecureString

# Convert secure strings to plain text
$aws_access_key_id = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($aws_access_key_id))
$aws_secret_access_key = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($aws_secret_access_key))

# Set environment variables
[System.Environment]::SetEnvironmentVariable("AWS_ACCESS_KEY_ID", $aws_access_key_id)
[System.Environment]::SetEnvironmentVariable("AWS_SECRET_ACCESS_KEY", $aws_secret_access_key)

# Prompt for other inputs
$region = Read-Host "Enter AWS region where you want to deploy"
$ami_id = Read-Host "Enter ID for Amazon Machine Image for EC2"

# Change directory to the appropriate template directory
# Check if number is less than 10 to modify how to access Terraform template directory
if ([int]$number -lt 10) {
    Set-Location "template0$number*"
} else {
    Set-Location "template$number*"
}

# Create terraform.tfvars file and write variables to it
"region = `"$region`"" | Out-File terraform.tfvars -Encoding UTF8
"ami_id = `"$ami_id`"" | Out-File terraform.tfvars -Encoding UTF8 -Append

# Initialize, plan, and apply Terraform configuration
terraform init
terraform plan
terraform apply