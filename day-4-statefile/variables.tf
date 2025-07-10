variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type = string
  default = "ami-020cba7c55df1f615"
}

variable "instance_type" {
    description = "Instance type for EC2"
    type = string
    default = "t2.micro"
  
}