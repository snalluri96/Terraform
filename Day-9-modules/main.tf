# Day-9-modules/main.tf
resource "aws_instance" "name" {
  ami               = var.ami_id
  instance_type     = var.instance_type
  key_name          = var.key
  availability_zone = var.az
  tags = {
    Name = "dev" # Example tag, ideally also a variable
  }
}
