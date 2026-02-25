### 13. Security groups resource

# Admin SG:
resource "aws_security_group" "dev_adminsg" {
  description = "Dev Admin security group"
  name        = "DevAdminSecurityGroup"
  vpc_id = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
  ingress {
    cidr_blocks = ["10.12.248.0/22"]
    description = ""
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }
  ingress {
    cidr_blocks = ["10.12.248.11/32"]
    description = "Dev Jumphost-1"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }
  ingress {
    cidr_blocks = ["10.12.248.11/32"]
    description = "Dev Jumphost-1"
    from_port   = 3389
    protocol    = "tcp"
    to_port     = 3389
  }
  ingress {
    cidr_blocks = ["10.12.249.11/32"]
    description = "Devops server"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
  ingress {
    cidr_blocks = ["10.11.8.0/21"]
    description = "VPN CIDR range-1"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }
  ingress {
    cidr_blocks = ["10.11.8.0/22"]
    description = "VPN CIDR range-2"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }
  ingress {
    cidr_blocks = ["10.11.0.0/18"]
    description = "OnPrem VPN range"
    from_port   = 3389
    protocol    = "tcp"
    to_port     = 3389
  }

  tags = {
    Application = "WC"
    Costcenter  = "123"
    Environment = "Dev"
    Name        = "Dev-AdminSG"
    Owner       = "user1@example.com"
  }
}

# App SG:
resource "aws_security_group" "dev_appsg" {
  description = "Dev Application Security Group"
  name        = "DevAppSecurityGroup"
  vpc_id = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["10.0.0.0/8"]
    description = ""
    from_port   = 137
    protocol    = "tcp"
    to_port     = 139
  }
  ingress {
    cidr_blocks = ["10.0.0.0/8"]
    description = ""
    from_port   = 2049
    protocol    = "tcp"
    to_port     = 2049
  }
  ingress {
    cidr_blocks = ["10.0.0.0/8"]
    description = ""
    from_port   = 20
    protocol    = "tcp"
    to_port     = 21
  }
  ingress {
    cidr_blocks = ["10.0.0.0/8"]
    description = ""
    from_port   = 389
    protocol    = "tcp"
    to_port     = 389
  }
  ingress {
    cidr_blocks = ["10.0.0.0/8"]
    description = ""
    from_port   = 445
    protocol    = "tcp"
    to_port     = 445
  }
  ingress {
    cidr_blocks = ["10.0.0.0/8"]
    description = "CAD Worker"
    from_port   = 5600
    protocol    = "tcp"
    to_port     = 5600
  }
  ingress {
    cidr_blocks = ["10.0.0.0/8"]
    description = "ICMP"
    from_port   = -1
    protocol    = "icmp"
    to_port     = -1
  }
  ingress {
    cidr_blocks = ["10.12.248.11/32"]
    description = "Dev1 Creo "
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
  ingress {
    cidr_blocks = ["10.11.11.11/32"]
    description = "SFTP"
    from_port   = 2222
    protocol    = "tcp"
    to_port     = 2222
  }
  ingress {
    cidr_blocks = ["10.11.11.11/32"]
    description = "SFTP"
    from_port   = 61616
    protocol    = "tcp"
    to_port     = 61616
  }
  ingress {
    cidr_blocks     = ["0.0.0.0/0"]
    description     = ""
    from_port       = 443
    protocol        = "tcp"
    to_port         = 443
  }
  ingress {
    cidr_blocks     = ["0.0.0.0/0"]
    description     = "common EFS SG"
    from_port       = 0
    protocol        = "-1"
    to_port         = 0
  }

  tags = {
    Application = "WC"
    Costcenter  = "123"
    Environment = "Dev"
    Name        = "Dev1-AppSG"
    Owner       = "user1@example.com"
  }
}

# EFS SG:
resource "aws_security_group" "dev_efssg" {
  description = "Dev EFS security group"
  name        = "DevEFSSecurityGroup"
  vpc_id = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["10.0.0.0/8"]
    description = ""
    from_port   = 2049
    protocol    = "tcp"
    to_port     = 2049
  }

  tags = {
    Application = "WC"
    Costcenter  = "123"
    Environment = "Dev"
    Name        = "Dev1-EFSSG"
    Owner       = "user1@example.com"
  }
}

