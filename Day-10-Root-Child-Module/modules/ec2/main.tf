# modules/ec2/main.tf
resource "aws_instance" "name" {
  ami           = var.ami_id # [cite: 845]
  instance_type = var.instance_type # [cite: 847]
  key_name      = var.key # [cite: 849]
 
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id     = var.subnet_id
  tags = {
    Name = "my-child-ec3"
  }
   lifecycle {
    create_before_destroy = true # [cite: 1329]
  }

}