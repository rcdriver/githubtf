#terraform {
#  backend "s3" {
#    bucket = "tfdev-backend"
#    key    = "state"
#    region = "ap-south-1"
#  }
#}

#terraform {
#  backend "s3" {
#    bucket       = "tfdev-backend"
#    key          = "tfstate/terraform.tfstate"
#    region       = "ap-south-1"
#    # NEW: Enables native locking without DynamoDB
#    use_lockfile = true 
#  }
#}

terraform {
  backend "s3" {
    region = "ap-south-1"

  }
}
