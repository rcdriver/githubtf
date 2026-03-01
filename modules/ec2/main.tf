locals {
  common_tags = {
    AWSBackup    = "Daily"
    AWSBackupEnv = "Dev"
    Application  = "WC"
    Costcenter   = "123"
    Environment  = "Dev"
    Owner        = "abc@example.com"
    ec2_start    = "Sun_10_30pm"
    ec2_stop     = "Sat_4am"
  }
}

resource "aws_instance" "dev_app_servers" {
  for_each = var.dev_instances

  ami                    = var.primary_region_ami
  instance_type          = var.dev_instance_type
  iam_instance_profile   = var.dev_iam_instance_profile_name
  subnet_id              = each.value.subnet_id
  key_name               = var.dev_key_name
  vpc_security_group_ids = var.dev_security_group_ids

  user_data_base64 = filebase64("${path.module}/install_ssm.sh")

  dynamic "root_block_device" {
    for_each = var.dev_root_volume_settings
    content {
      delete_on_termination = true
      encrypted             = true
      volume_size           = root_block_device.value.size
      volume_type           = root_block_device.value.type
      iops                  = root_block_device.value.iops
      throughput            = root_block_device.value.throughput
    }
  }

  dynamic "ebs_block_device" {
    for_each = var.dev_ebs_volume_settings
    content {
      delete_on_termination = false
      device_name           = ebs_block_device.value.name
      encrypted             = true
      volume_size           = ebs_block_device.value.size
      volume_type           = ebs_block_device.value.type
      iops                  = ebs_block_device.value.iops
      throughput            = ebs_block_device.value.throughput
    }
  }

  tags = merge(
    local.common_tags,
    {
      Name = each.value.name
    }
  )
}
