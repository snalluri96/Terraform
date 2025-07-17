# Data block to retrieve an existing subnet by tag
# IMPORTANT: Ensure you have a subnet in your AWS account tagged with Name = "dev"
data "aws_subnet" "name" { # Renamed from "existing_dev_subnet" to match your provided code
  filter {
    name   = "tag:Name"
    values = ["dev"] # Replace with the actual tag value of your existing subnet
  }
}


# Data block to retrieve the latest Amazon Linux 2 AMI
data "aws_ami" "amzlinux" {
  most_recent = true
  owners      = ["amazon"] # Owned by Amazon
filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}
# Resource to create an EC2 instance using the retrieved AMI and Subnet
resource "aws_instance" "name" {
  ami           = data.aws_ami.amzlinux.id # Uses the ID from the data block
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.name.id  # Uses the ID from the data block
  tags = {
    Name = "MyTerraformEC2"
  }
}
# --- AWS Lambda Function and IAM Role ---
# Create IAM role for Lambda function
resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"
assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Attach basic execution policy to the Lambda role
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
# Create the Lambda function
resource "aws_lambda_function" "my_lambda" {
  function_name = "my_lambda_function"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler" # Entry point of your Lambda function
  runtime       = "python3.12"
  timeout       = 900
  memory_size   = 128
# Filename and source_code_hash are crucial for Lambda deployment
  filename         = "lambda_function.zip" # Ensure this file exists in the same directory
  
}

# Output the Lambda function name
output "lambda_function_name" {
  description = "The name of the deployed Lambda function"
  value       = aws_lambda_function.my_lambda.function_name
}
