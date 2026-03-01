output "dev_instance_ids" {
  value = { for k, v in aws_instance.dev_app_servers : k => v.id }
}