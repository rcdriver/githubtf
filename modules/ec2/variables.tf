variable "vpc_id" { 
  type = string 
  }

#variable "dev_private_subnet_az1" { 
#  type = string 
#  }

#variable "dev_private_subnet_az2" { 
#  type = string 
#  }

#variable "dev_public_subnet_az1" { 
#  type = string 
#  }

#variable "dev_public_subnet_az2" { 
#  type = string 
#  }

variable "primary_region_ami" {
  type    = string
  default = "ami-051a31ab2f4d498f5"
}

variable "dev_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "dev_ec2_instance_profile_name" {
  type = string
}

variable "dev_public_subnet_az1_id" {
  type = string
}

variable "dev_public_subnet_az2_id" {
  type = string
}

variable "dev_private_subnet_az1_id" {
  type = string
}

variable "dev_private_subnet_az2_id" {
  type = string
}


variable "dev_adminsg_id" {
  type = string
}

variable "dev_appsg_id" {
  type = string
}

variable "dev_efssg_id" {
  type = string
}

