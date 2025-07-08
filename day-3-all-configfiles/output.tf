output "ip" {
    value = aws_instance.name1.public_ip
     
}

output "privateip" {
    value = aws_instance.name2.private_ip
     
}