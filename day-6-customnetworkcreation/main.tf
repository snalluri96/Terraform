resource "aws_vpc" "name" {
cidr_block = "10.0.0.0/16" # Example CIDR block for your VPC
  tags = {
    Name = "test-vpc"
  }
}
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.name.id
  cidr_block        = "10.0.100.0/24" # Example CIDR for a public subnet
  availability_zone = "us-east-1a"  # Specify an Availability Zone
  map_public_ip_on_launch = true # Automatically assign public IPs to instances
  tags = {
    Name = "test-public-subnet"
  }
}

resource "aws_internet_gateway" "main_ig" {
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "main-ig"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.name.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_ig.id
  }
  tags = {
    Name = "public-route-table"
  }
}
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.name.id
  cidr_block        = "10.0.1.0/24" # Example CIDR for a private subnet
  availability_zone = "us-east-1a"  # Specify an Availability Zone
  tags = {
    Name = "test-private-subnet"
  }
}
resource "aws_security_group" "allow_web_ssh" {
  name        = "allow_web_ssh"
  description = "Allow web and SSH inbound traffic"
  vpc_id      = aws_vpc.name.id
ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
egress { # Outbound rule
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
    Name = "dev_sg"
  }
}
resource "aws_instance" "name" {
  ami                    = "ami-020cba7c55df1f615" # Example AMI ID, use a valid one for your region
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id # Attaches to the created public subnet
  vpc_security_group_ids = [aws_security_group.allow_web_ssh.id] # Attaches to the security group
  tags = {
    Name = "my-web-server"
  }
}
resource "aws_eip" "nat_gateway_eip" {
  tags = {
    Name = "nat-gateway-eip"
  }
}
resource "aws_nat_gateway" "main_nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.public_subnet.id # NAT Gateway must be in a public subnet
  tags = {
    Name = "main-nat-gateway"
  }
  depends_on = [aws_eip.nat_gateway_eip] # Ensures EIP is created first
}
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.name.id
route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main_nat_gateway.id # Direct traffic through NAT Gateway
  }
  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_instance" "private_instance" {
  ami           = "ami-020cba7c55df1f615" # Use a valid AMI for your region
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet.id # Place in private subnet
  # Attach relevant security groups here for inbound/outbound rules
  # For a private instance, you would typically only allow SSH/etc. from a bastion host in a public subnet
  tags = {
    Name = "my-private-instance"
  }
}
