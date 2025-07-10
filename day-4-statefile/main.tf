resource "aws_instance" "my_single_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = "day4-demo-instance"
  }
}