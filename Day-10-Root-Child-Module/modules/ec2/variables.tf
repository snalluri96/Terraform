# modules/ec2/variables.tf
variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t2.micro" # [cite: 815]
}

variable "key" {
  description = "The key pair name for the EC2 instance"
  type        = string
}

variable "az" {
  description = "The availability zone for the EC2 instance"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs"
  type        = list(string)
}

variable "subnet_id" {
  description = "The ID of the subnet to launch the instance into"
  type        = string
}