resource "aws_sns_topic" "dev_warning_alarm" {
  name = "cloudteam-warning-alarm-topic"
}

resource "aws_sns_topic" "dev_actual_alarm" {
  name = "cloudteam-actual-alarm-topic"
}


resource "aws_sns_topic_subscription" "dev_warning_alarm_subscription" {
  for_each  = toset(var.team_emails)
  topic_arn = aws_sns_topic.dev_warning_alarm.arn
  protocol  = "email"
  endpoint  = each.value
}

resource "aws_sns_topic_subscription" "dev_actual_alarm_subscription" {
  for_each  = toset(var.team_emails)
  topic_arn = aws_sns_topic.dev_actual_alarm.arn
  protocol  = "email"
  endpoint  = each.value
}
