# modules/vpc/main.tf
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block # [cite: 1242]
  tags = {
    Name = "my-child-vpc"
  }
}
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id # [cite: 1268]
  cidr_block = var.subnet_cidr # [cite: 1268]
  
  tags = {
    Name = "my-child-subnet"
  }
}