terraform {
  backend "s3" {
    bucket         = "test-terraform-san" # Replace with your S3 bucket name
    key            = "test/terraform.tfstate"      # Path to your state file within the bucket
    region         = "us-east-1"              # Your AWS region
    dynamodb_table = "TerraformStateLockTable" # Name of your DynamoDB lock table
    encrypt        = true                     # Optional: Encrypt state file in S3
  }
}