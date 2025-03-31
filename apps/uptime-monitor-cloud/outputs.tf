output "smtp_username_secret_arn" {
  value = aws_secretsmanager_secret.smtp_username.arn
}

output "smtp_password_secret_arn" {
  value = aws_secretsmanager_secret.smtp_password.arn
}