locals {
  warning_threshold  = 70
  critical_threshold = 80
}

resource "aws_cloudwatch_metric_alarm" "ec2_cpu_warning_alarm" {
  for_each = var.instance_ids

  alarm_name          = "${each.key}-CPUUtilization-Warning"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300" # 5 minutes
  statistic           = "Average"
  threshold           = local.warning_threshold
  alarm_description   = "CPU warning alarm for ${each.key}"
  
  alarm_actions       = [ var.warning_sns_topic_arn ]
  ok_actions          = [ var.warning_sns_topic_arn ]

  dimensions = {
    InstanceId = each.value
  }
}

resource "aws_cloudwatch_metric_alarm" "ec2_cpu_actual_alarm" {
  for_each = var.instance_ids

  alarm_name          = "${each.key}-CPUUtilization-Actual"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300" # 5 minutes
  statistic           = "Average"
  threshold           = local.critical_threshold
  alarm_description   = "CPU actual alarm for ${each.key}"
  
  alarm_actions       = [ var.actual_sns_topic_arn ]
  ok_actions          = [ var.actual_sns_topic_arn ]

  dimensions = {
    InstanceId = each.value
  }
}
