# Capture the VPC ID from the VPC module
output "vpc_id" {
  value = module.vpc.vpc_id
}

# Capture the Subnet IDs map from the VPC module
output "all_subnet_ids" {
  value = module.vpc.subnet_ids
}
