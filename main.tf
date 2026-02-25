module "vpc" {
  source = "./modules/vpc"
}

module "s3" {
  source = "./modules/s3"
}

module "ec2" {
  source = "./modules/ec2"
  vpc_id                = module.vpc.vpc_id

  dev_ec2_instance_profile_name = module.iam.dev_ec2_instance_profile_name

  dev_public_subnet_az1_id = module.vpc.dev_public_subnet_az1_id
  dev_public_subnet_az2_id = module.vpc.dev_public_subnet_az2_id
  dev_private_subnet_az1_id = module.vpc.dev_private_subnet_az1_id
  dev_private_subnet_az2_id = module.vpc.dev_private_subnet_az2_id

#  dev_public_subnet_az1 = module.vpc.dev_public_subnet_az1_id
#  dev_public_subnet_az2 = module.vpc.dev_public_subnet_az2_id
#  dev_private_subnet_az1 = module.vpc.dev_private_subnet_az1_id
#  dev_private_subnet_az2 = module.vpc.dev_private_subnet_az2_id

  dev_adminsg_id  = module.securitygroup.dev_adminsg_id
  dev_appsg_id    = module.securitygroup.dev_appsg_id
  dev_efssg_id    = module.securitygroup.dev_efssg_id

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
