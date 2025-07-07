resource "aws_instance" "example_instance" {
    ami = "ami-05ffe3c48a9991133"
    instance_type = "t3.micro"
    tags = {
      Name = "MyTerraformInstance"
    }
  
}