module "vpc" {
  source = "./modules/vpc"
}

module "s3" {
  source = "./modules/s3"
}

module "ec2" {
  source = "./modules/ec2"
  
  primary_region_ami              = "ami-051a31ab2f4d498f5"
  dev_instance_type               = "t3.micro"
  dev_iam_instance_profile_name   = module.iam.dev_ec2_instance_profile_name
  dev_key_name                    = "dev_key_name"
  
  # Grouping SGs into the list expected by the module
  dev_security_group_ids          = [
    module.securitygroup.dev_adminsg_id, 
    module.securitygroup.dev_appsg_id
  ]
  
  # Mapping instances to their specific subnets
  dev_instances = {
    server1 = { 
      subnet_id = module.vpc.dev_public_subnet_az1_id, 
      name      = "Dev1AppServer" 
    },
    server2 = { 
      subnet_id = module.vpc.dev_public_subnet_az2_id, 
      name      = "Dev2AppServer" 
    }
  }

  dev_root_volume_settings = [{ 
    size = 15, type = "gp3", iops = 3000, throughput = 125 
  }]

  dev_ebs_volume_settings  = [{ 
    name = "/dev/sdb", size = 2, type = "gp3", iops = 3000, throughput = 125 
  }]
}


module "iam" {
  source = "./modules/iam"
}

module "efs" {
  source = "./modules/efs"
  dev_public_subnet_az1_id = module.vpc.dev_public_subnet_az1_id
  dev_public_subnet_az2_id = module.vpc.dev_public_subnet_az2_id
  dev_private_subnet_az1_id = module.vpc.dev_private_subnet_az1_id
  dev_private_subnet_az2_id = module.vpc.dev_private_subnet_az2_id
  dev_efssg_id = module.securitygroup.dev_efssg_id
}

module "securitygroup" {
  source = "./modules/securitygroup"
  vpc_id = module.vpc.vpc_id
}

#module "sns" {
#  source = "./module/sns"
#}

#module "cloudwatch" {
#  source = "./module/cloudwatch"
#  instance_ids            = module.ec2.instance_ids
#  warning_sns_topic_arn   = aws_sns_topic.dev_warning_alarm.arn
#  critical_sns_topic_arn  = aws_sns_topic.dev_actual_alarm.arn
#}

