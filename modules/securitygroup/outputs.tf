output "dev_adminsg_id" {
  description = "Dev Admin SG ID"
  value       = aws_security_group.dev_adminsg.id
}

output "dev_appsg_id" {
  description = "Dev App SG ID"
  value       = aws_security_group.dev_appsg.id
}

output "dev_efssg_id" {
  description = "Dev EFS SG ID"
  value       = aws_security_group.dev_efssg.id
}

