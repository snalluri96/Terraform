terraform {
  backend "s3" {
    bucket = "terraform-day-5-test-san" # Replace with your S3 bucket name
    key    = "terraform.tfstate"   # Path to your state file within the bucket
    region = "us-east-1"           # Your AWS region
    use_lockfile = true
      }
}