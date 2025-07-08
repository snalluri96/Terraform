resource "aws_instance" "name1" {
  ami = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = "day3"
  }
}

resource "aws_instance" "name2" {
  ami = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = "day4"
  }
}