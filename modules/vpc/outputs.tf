output "vpc_id" {
  value = aws_vpc.Dev_VPC.id
}

output "subnet_ids" {
  value = {
    public_subnet_az1  = aws_subnet.dev_public_subnet_az1.id
    public_subnet_az2  = aws_subnet.dev_public_subnet_az2.id
    private_subnet_az1 = aws_subnet.dev_private_subnet_az1.id
    private_subnet_az2 = aws_subnet.dev_private_subnet_az2.id
  }
}
