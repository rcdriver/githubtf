module "vpc" {
  source = "./modules/vpc"
}

#module "ec2" {
#  source = "./modules/ec2"
#  vpc_id             = module.vpc.vpc_id
#  private_subnet_az1 = module.vpc.subnet_ids["private_subnet_az1"]
#  private_subnet_az2 = module.vpc.subnet_ids["private_subnet_az2"]
#}

module "s3" {
  source = "./modules/s3"
}

