output "vpc_id" {
  value = aws_vpc.dev_vpc.id
}

output "dev_public_subnet_az1_id" {
  value = aws_subnet.dev_public_subnet_az1.id
}

output "dev_public_subnet_az2_id" {
  value = aws_subnet.dev_public_subnet_az2.id
}

output "dev_private_subnet_az1_id" {
  value = aws_subnet.dev_private_subnet_az1.id
}

output "dev_private_subnet_az2_id" {
  value = aws_subnet.dev_private_subnet_az2.id
}
