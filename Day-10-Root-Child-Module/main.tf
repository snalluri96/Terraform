# main.tf (Root Configuration)
module "vpc" {
  source    = "./modules/vpc" # [cite: 1208]
  cidr_block = var.vpc_cidr_block # [cite: 1210]
  subnet_cidr = var.subnet_cidr
  az          = var.az
}

module "ec2" {
  source                 = "./modules/ec2" # [cite: 1218]
  ami_id                 = var.ami_id
  instance_type          = var.instance_type
  key                    = var.key_name
  az                     = var.az
  subnet_id              = module.vpc.subnet_id # Referencing output from vpc module
  vpc_security_group_ids = [var.security_group_id] # Assuming you have a security group ID
}
