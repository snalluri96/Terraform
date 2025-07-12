resource "aws_instance" "name" {
  ami           = "ami-020cba7c55df1f615" 
  instance_type = "t2.micro"
   tags = {
    Name = "day6"
  }
}

resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
}