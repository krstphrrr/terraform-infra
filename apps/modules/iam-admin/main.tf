resource "aws_iam_user" "admin" {
  name = var.name
  tags = var.tags
}

resource "aws_iam_access_key" "admin" {
  user = aws_iam_user.admin.name

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_iam_user_policy" "admin_policy" {
  name = "${var.name}-policy"
  user = aws_iam_user.admin.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = var.allowed_actions,
        Resource = "*"
      }
    ]
  })
}
