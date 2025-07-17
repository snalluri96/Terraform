# Day-9a-module-calling/main.tf
module "project" {
  source = "../Day-9-modules" # - Relative path to your module
  ami_id        = "ami-05ffe3c48a9991133"
  instance_type = "t2.micro"
    az            = "us-east-1a"
}