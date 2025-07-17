# modules/vpc/outputs.tf
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id # [cite: 1244, 1278]
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = aws_subnet.main.id # [cite: 1280]
}