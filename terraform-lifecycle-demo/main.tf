# main.tf
resource "aws_instance" "test_instance" {
  ami           = "ami-020cba7c55df1f615" # Replace with a valid AMI ID for your region (e.g., Amazon Linux 2)
  instance_type = "t2.medium"
  
  tags = {
    Name        = "LifecycleDemoInstance"
    Environment = "Dev1"
  }

  }
