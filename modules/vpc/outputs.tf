output "vpc_id" {
  value = aws_vpc.dev_vpc.id
}

output "subnet_ids" {
  value = {
    public_subnet_az1  = aws_subnet.dev_public_subnet_az1.id
    public_subnet_az2  = aws_subnet.dev_public_subnet_az2.id
    private_subnet_az1 = aws_subnet.dev_private_subnet_az1.id
    private_subnet_az2 = aws_subnet.dev_private_subnet_az2.id
  }
}
