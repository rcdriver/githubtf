### resource blocks

#resource "aws_key_pair" "dev_key" {
#  key_name   = "dev-key"
#  public_key = file("${path.module}/.ssh/id_rsa.pub")
#}

### 11. EC2 instance resource

resource "aws_instance" "dev1app1" {
  ami                    = var.primary_region_ami
  instance_type          = var.dev_instance_type
#  iam_instance_profile   = module.iam.dev_ec2_instance_profile_name.name
  iam_instance_profile = var.dev_ec2_instance_profile_name
#  subnet_id              = module.vpc.dev_public_subnet_az1_id
  subnet_id = var.dev_public_subnet_az1_id
#  vpc_security_group_ids = [
#    module.securitygroup.dev_adminsg_id,
#    module.securitygroup.dev_appsg_id,
#    module.securitygroup.dev_efssg_id
#    ]

  vpc_security_group_ids = [
    var.dev_adminsg_id,
    var.dev_appsg_id,
    var.dev_efssg_id
    ]

  key_name = var.dev_key_name

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
