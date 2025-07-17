# variables.tf (Root Configuration)
variable "vpc_cidr_block" {
  description = "The CIDR block for the main VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "az" {
  description = "The Availability Zone to deploy resources into"
  type        = string
  default     = "us-east-1a"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-05ffe3c48a9991133" # Example AMI, replace with a valid one for your region [cite: 917]
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t2.micro" # [cite: 918]
}

variable "key_name" {
  description = "The key pair name for EC2 instance"
  type        = string
  default     = "my-ec2-key" # Replace with your actual key pair name
}

variable "security_group_id" {
  description = "A pre-existing security group ID for the EC2 instance"
  type        = string
  # IMPORTANT: Replace with a real security group ID that allows necessary traffic
  default     = "sg-0abcdef1234567890"
}