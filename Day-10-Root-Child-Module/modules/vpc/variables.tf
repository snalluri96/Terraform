# modules/vpc/variables.tf
variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
  type        = string
}

variable "az" {
  description = "The availability zone for the subnet"
  type        = string
}