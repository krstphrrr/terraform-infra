output "user_name" {
  value       = var.identity_type == "user" ? aws_iam_user.identity[0].name : null
  description = "Created IAM user name"
}

output "access_key" {
  value = var.identity_type == "user" ? {
    id     = aws_iam_access_key.access_key[0].id
    secret = aws_iam_access_key.access_key[0].secret
  } : null
  sensitive = true
}

output "role_name" {
  value       = var.identity_type == "role" ? aws_iam_role.identity[0].name : null
  description = "Created IAM role name"
}