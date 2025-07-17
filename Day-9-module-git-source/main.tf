module "name" {
    source = "git::https://github.com/snalluri96/Terraform.git//Day-9-modules"
    ami_id        = "ami-05ffe3c48a9991133"
    instance_type = "t2.micro"
  # key         = "test" # commented out in source
  az            = "us-east-1a"
}
