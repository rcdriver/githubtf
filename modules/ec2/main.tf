### resource blocks

resource "aws_key_pair" "dev_key" {
  key_name   = "dev-key"
  public_key = file("${path.module}/.ssh/id_rsa.pub")
}

### 11. EC2 instance resource

resource "aws_instance" "dev1app1" {
  ami                    = var.primary_region_ami
  instance_type          = var.dev_instance_type
  iam_instance_profile   = aws_iam_instance_profile.ec2_ssm_instance_profile.id
  subnet_id              = var.dev_public_subnet_az1.id
  vpc_security_group_ids = [
    aws_security_group.adminsg.id,
    aws_security_group.appsg.id,
    aws_security_group.efssg.id
  ]

  key_name = aws_key_pair.dev_key.key_name

  user_data_base64 = filebase64("${path.module}/install_ssm.sh")

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    iops                  = 3000
    throughput            = 125
    volume_size           = 15
    volume_type           = "gp3"
  }
  ebs_block_device {
    delete_on_termination = false
    device_name           = "/dev/sdb"
    encrypted             = true
    iops                  = 3000
    ###    kms_key_id            = "arn:aws:kms:eu-central-1:573626777469:key/62f3bb6f-663c-48db-a30e-59c96d51950b"
    throughput  = 125
    volume_size = 2
    volume_type = "gp3"
  }
    tags = {
    AWSBackup    = "Daily"
    AWSBackupEnv = "Dev"
    Application  = "WC"
    Costcenter   = "123"
    Environment  = "Dev"
    Name         = "Dev1AppServer"
    Owner        = "abc@example.com"
    ec2_start    = "Sun_10_30pm"
    ec2_stop     = "Sat_4am"
  }

}

### 12. Instance profile, IAM Role, IAM Policy resource
# IAM Role for EC2 without using data block
resource "aws_iam_role" "ec2_ssm_role" {
  name = "ec2_ssm_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach Amazon SSM Managed Policy to the role
resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "ec2_ssm_instance_profile" {
  name = "my-ec2-instance-profile"
  role = aws_iam_role.ec2_ssm_role.name
}

### 13. Security groups resource
# Admin SG:
resource "aws_security_group" "adminsg" {
  description = "Admin security group"
  name        = "AdminSecurityGroup"
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
    cidr_blocks = ["10.11.11.0/21"]
    description = "VPN CIDR range-1"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }
  ingress {
    cidr_blocks = ["10.11.11./22"]
    description = "VPN CIDR range-2"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }
  ingress {
    cidr_blocks = ["10.11.11.0/18"]
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
resource "aws_security_group" "appsg" {
  description = "ELGPLM-Dev1-AppSG"
  name        = "ELGPLM-Dev1-AppSG"
  region      = "eu-central-1"
  vpc_id      = var.vpc_id


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
    cidr_blocks     = []
    description     = ""
    from_port       = 443
    protocol        = "tcp"
    security_groups = ["sg-000cca411bc52492a"] #XXX
    to_port         = 443
  }
  ingress {
    cidr_blocks     = []
    description     = "common EFS SG"
    from_port       = 0
    protocol        = "-1"
    security_groups = ["sg-07360802c6040f65e"] #XXX
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
resource "aws_security_group" "efssg" {
  description = "EFS-SG"
  name        = "EFS-SG"
  region      = "eu-central-1"
  vpc_id      = var.vpc_id


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

### 14. EFS resource
resource "aws_efs_file_system" "dev_efs" {
  region           = "eu-central-1"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  #  encrypted = true

  tags = {
    Name = "dev_efs"
  }
}

resource "aws_efs_mount_target" "dev_efs_mt_az1" {
  file_system_id  = aws_efs_file_system.dev_efs.id
  subnet_id       = var.private_subnet_az1
  security_groups = [aws_security_group.efssg.id]
}

resource "aws_efs_mount_target" "dev_efs_mt_az2" {
  file_system_id  = aws_efs_file_system.dev_efs.id
  subnet_id          = var.private_subnet_az2
  security_groups = [aws_security_group.efssg.id]
}
