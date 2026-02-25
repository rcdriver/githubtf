### 14. EFS resource
resource "aws_efs_file_system" "dev_efs1" {
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  #  encrypted = true

  tags = {
    Name = "Dev-efs1"
  }
}

resource "aws_efs_mount_target" "dev_efs1_mt_az1" {
  file_system_id  = aws_efs_file_system.dev_efs1.id
#  subnet_id       = module.vpc.dev_public_subnet_az1_id
  subnet_id = var.dev_public_subnet_az1_id
#  security_groups = [module.securitygroup.dev_efssg_id]
  security_groups = [var.dev_efssg_id]
}

resource "aws_efs_mount_target" "dev_efs1_mt_az2" {
  file_system_id  = aws_efs_file_system.dev_efs1.id
#  subnet_id       = module.vpc.dev_public_subnet_az2_id
  subnet_id = var.dev_public_subnet_az2_id
#  security_groups = [module.securitygroup.dev_efssg_id]
  security_groups = [var.dev_efssg_id]
}
