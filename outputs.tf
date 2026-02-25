# Capture the VPC ID from the VPC module
output "vpc_id" {
  value = module.vpc.vpc_id
}

# Capture the subnet IDs from the VPC module
output "dev_public_subnet_az1_id" {
  value = module.vpc.dev_public_subnet_az1_id
} 
output "dev_public_subnet_az2_id" {
  value = module.vpc.dev_public_subnet_az2_id
} 
output "dev_private_subnet_az1_id" {
  value = module.vpc.dev_private_subnet_az1_id
} 
output "dev_private_subnet_az2_id" {
  value = module.vpc.dev_private_subnet_az2_id
} 
