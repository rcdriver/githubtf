### 1. VPC:
resource "aws_vpc" "Dev_VPC" {
  cidr_block = var.dev_vpc

  tags = {
    Name = "Dev_VPC"
  }
}

### 2. IGW:
resource "aws_internet_gateway" "Dev_IGW" {
  vpc_id = aws_vpc.Dev_VPC.id

  tags = {
    Name = "Dev_IGW"
  }
}

### 3. Public subnet:
resource "aws_subnet" "dev_public_subnet_az1" {
  vpc_id              = aws_vpc.Dev_VPC.id
  cidr_block          = var.dev_public_subnet_az1
  availability_zone_id = var.mum_az1

  tags = {
    Name = "dev_public_subnet_az1"
  }
}

resource "aws_subnet" "dev_public_subnet_az2" {
  vpc_id              = aws_vpc.Dev_VPC.id
  cidr_block          = var.dev_public_subnet_az2
  availability_zone_id = var.mum_az2

  tags = {
    Name = "dev_public_subnet_az2"
  }
}

### 4. Private subnet:
resource "aws_subnet" "dev_private_subnet_az1" {
  vpc_id              = aws_vpc.Dev_VPC.id
  cidr_block          = var.dev_private_subnet_az1
  availability_zone_id = var.mum_az1

  tags = {
    Name = "dev_private_subnet_az1"
  }
}

resource "aws_subnet" "dev_private_subnet_az2" {
  vpc_id              = aws_vpc.Dev_VPC.id
  cidr_block          = var.dev_private_subnet_az2
  availability_zone_id = var.mum_az2

  tags = {
    Name = "dev_private_subnet_az2"
  }
}

### 5. Public RT
resource "aws_route_table" "Dev_Public_RT" {
  vpc_id = aws_vpc.Dev_VPC.id

  route {
    cidr_block = var.internet_ip
    gateway_id = aws_internet_gateway.Dev_IGW.id
  }

  tags = {
    Name = "Dev-Public-RT"
  }
}

resource "aws_route_table_association" "publicRT-assoiation" {
  subnet_id      = aws_subnet.dev_public_subnet_az1.id
  route_table_id = aws_route_table.Dev_Public_RT.id
}

### 6. EIP
### Commented it due to cost issues
resource "aws_eip" "Dev-Nat-EIP" {}

### 7. NAT Gateway
### Commented it due to cost issues
resource "aws_nat_gateway" "Dev-NGW" {
  allocation_id = aws_eip.Dev-Nat-EIP.id
  subnet_id     = aws_subnet.dev_public_subnet_az1.id

  tags = {
    Environment = "Dev-NGW"
  }
}

### 8. Private RT
resource "aws_route_table" "dev-private-rt" {
  vpc_id = aws_vpc.Dev_VPC.id

  route {
    cidr_block     = var.internet_ip
    nat_gateway_id = aws_nat_gateway.Dev-NGW.id
  }

  tags = {
    Name = "Dev-Private-RT"
  }
}

resource "aws_route_table_association" "privateRT-association" {
  subnet_id      = aws_subnet.dev_private_subnet_az1.id
  route_table_id = aws_route_table.dev-private-rt.id
}
