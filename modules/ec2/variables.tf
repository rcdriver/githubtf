variable "vpc_id" { 
  type = string 
  }

variable "private_subnet_az1" { 
  type = string 
  }

variable "private_subnet_az2" { 
  type = string 
  }

variable "primary_region_ami" {
  type    = string
  default = "ami-0a6793a25df710b06"
}

variable "dev_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "dev_pem_key" {
  type    = string
  default = "dev-key"
}

