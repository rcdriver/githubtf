variable "primary_region_ami" {
  type = string
}

variable "dev_instance_type" {
  type = string
}

variable "dev_iam_instance_profile_name" {
  type = string
}

variable "dev_key_name" {
  type = string
}

variable "dev_security_group_ids" {
  type = list(string)
}

variable "dev_instances" {
  type = map(object({
    subnet_id = string
    name      = string
  }))
}

variable "dev_root_volume_settings" {
  type = list(object({
    size       = number
    type       = string
    iops       = number
    throughput = number
  }))
}

variable "dev_ebs_volume_settings" {
  type = list(object({
    name       = string
    size       = number
    type       = string
    iops       = number
    throughput = number
  }))
}