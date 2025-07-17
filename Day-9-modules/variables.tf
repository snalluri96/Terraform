
# Day-9-modules/variables.tf
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
  default     = ""
}

variable "key" {
  description = "Key pair name for the EC2 instance"
  type        = string
  default     = ""
}

variable "az" {
  description = "Availability Zone for the EC2 instance"
  type        = string
  default     = "us-east-1"
}