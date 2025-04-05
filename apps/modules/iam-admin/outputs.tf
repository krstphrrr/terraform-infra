output "access_key_id" {
  value     = aws_iam_access_key.admin.id
  sensitive = true
}

output "secret_access_key" {
  value     = aws_iam_access_key.admin.secret
  sensitive = true
}
