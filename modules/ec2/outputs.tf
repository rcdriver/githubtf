output "ec2-instance-id" {
  value = aws_instance.dev1.id
}

output "ec2-private-ip" {
  value = aws_instance.dev1.private_ip
}
