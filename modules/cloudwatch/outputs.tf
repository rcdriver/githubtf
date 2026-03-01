output "warning_alarm_arns" {
  value = {
    for k, v in aws_cloudwatch_metric_alarm.ec2_cpu_warning_alarm :
    k => v.arn
  }
}

output "critical_alarm_arns" {
  value = {
    for k, v in aws_cloudwatch_metric_alarm.ec2_cpu_actual_alarm :
    k => v.arn
  }
}
