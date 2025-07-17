# modules/ec2/outputs.tf
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.name.id
}

output "private_ip" {
  description = "The private IP of the EC2 instance"
  value       = aws_instance.name.private_ip
}