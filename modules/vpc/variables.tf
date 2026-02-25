variable "dev_vpc" { 
    type = string 
    default = "10.12.248.0/24" 
    }

variable "mum_az1" { 
    type = string 
    default = "aps1-az1" 
    }

variable "mum_az2" { 
    type = string 
    default = "aps1-az2" 
    }

variable "dev_public_subnet_az1_cidr" { 
    type = string 
    default = "10.12.248.128/28" 
    }

variable "dev_public_subnet_az2_cidr" { 
    type = string 
    default = "10.12.248.192/28" 
    }

variable "dev_private_subnet_az1_cidr" { 
    type = string 
    default = "10.12.248.0/26" 
    }

variable "dev_private_subnet_az2_cidr" { 
    type = string 
    default = "10.12.248.64/26" 
    }

variable "internet_ip" { 
    type = string 
    default = "0.0.0.0/0" 
    }
