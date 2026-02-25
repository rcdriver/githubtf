### 1. VPC:
resource "aws_vpc" "dev_vpc" {
  cidr_block = var.dev_vpc
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "Dev-VPC"
  }
}

### 2. IGW:
resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "Dev-IGW"
  }
}

### 3. Public subnet:
resource "aws_subnet" "dev_public_subnet_az1" {
  vpc_id              = aws_vpc.dev_vpc.id
  cidr_block          = var.dev_public_subnet_az1_cidr
  map_public_ip_on_launch = true
  availability_zone_id = var.mum_az1

  tags = {
    Name = "Dev-Public-Subnet-AZ1"
  }
}

resource "aws_subnet" "dev_public_subnet_az2" {
  vpc_id              = aws_vpc.dev_vpc.id
  cidr_block          = var.dev_public_subnet_az2_cidr
  map_public_ip_on_launch = true
  availability_zone_id = var.mum_az2

  tags = {
    Name = "Dev-Public-Subnet-AZ2"
  }
}

### 4. Private subnet:
resource "aws_subnet" "dev_private_subnet_az1" {
  vpc_id              = aws_vpc.dev_vpc.id
  cidr_block          = var.dev_private_subnet_az1_cidr
  availability_zone_id = var.mum_az1

  tags = {
    Name = "Dev-Private-Subnet-AZ1"
  }
}

resource "aws_subnet" "dev_private_subnet_az2" {
  vpc_id              = aws_vpc.dev_vpc.id
  cidr_block          = var.dev_private_subnet_az2_cidr
  availability_zone_id = var.mum_az2

  tags = {
    Name = "Dev-Private-Subnet-AZ2"
  }
}

### 5. Public RT
resource "aws_route_table" "dev_public_rt" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = var.internet_ip
    gateway_id = aws_internet_gateway.dev_igw.id
  }

  tags = {
    Name = "Dev-Public-RT"
  }
}

resource "aws_route_table_association" "publicrt_assoiation" {
  subnet_id      = aws_subnet.dev_public_subnet_az1.id
  route_table_id = aws_route_table.dev_public_rt.id
}

/*
### 6. EIP
# Commented it due to cost issues
resource "aws_eip" "dev_nat_eip" {

}

### 7. NAT Gateway
# Commented it due to cost issues
resource "aws_nat_gateway" "dev_ngw" {
  allocation_id = aws_eip.dev_nat_eip.id
  subnet_id     = aws_subnet.dev_public_subnet_az1.id

  tags = {
    Environment = "dev-ngw"
  }
}
*/

### 8. Private RT
resource "aws_route_table" "dev_private_rt" {
  vpc_id = aws_vpc.dev_vpc.id

#  route {
#    cidr_block     = var.internet_ip
#    #nat_gateway_id = aws_nat_gateway.dev_ngw.id
#    nat_gateway_id = ["10.0.0.0/8"]
#  }

  tags = {
    Name = "Dev-Private-RT"
  }
}

resource "aws_route_table_association" "privatert_association" {
  subnet_id      = aws_subnet.dev_private_subnet_az1.id
  route_table_id = aws_route_table.dev_private_rt.id
}

