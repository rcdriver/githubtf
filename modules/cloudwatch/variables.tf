variable "instance_ids" {
  description = "Map of EC2 instance names to IDs"
  type        = map(string)
}

variable "warning_sns_topic_arn" {
  type = string
}

variable "actual_sns_topic_arn" {
  type = string
}

