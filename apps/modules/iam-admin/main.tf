# Create IAM User (optional)
resource "aws_iam_user" "identity" {
  count = var.identity_type == "user" ? 1 : 0
  name  = var.name
  tags  = var.tags
}

resource "aws_iam_access_key" "access_key" {
  count = var.identity_type == "user" ? 1 : 0
  user  = aws_iam_user.identity[0].name

  lifecycle {
    prevent_destroy = true
  }
}

# Create IAM Role (optional)
resource "aws_iam_role" "identity" {
  count = var.identity_type == "role" ? 1 : 0
  name  = var.name
  assume_role_policy = jsonencode(var.assume_role_policy)
  tags = var.tags
}

# Inline policy attachment (common)
resource "aws_iam_user_policy" "identity_policy_user" {
  count = var.identity_type == "user" ? 1 : 0
  name  = "${var.name}-policy"
  user  = aws_iam_user.identity[0].name
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Action    = var.allowed_actions,
        Resource  = var.resources,
        Condition = var.conditions
      }
    ]
  })
}

resource "aws_iam_role_policy" "identity_policy_role" {
  count  = var.identity_type == "role" ? 1 : 0
  name   = "${var.name}-policy"
  role   = aws_iam_role.identity[0].name
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Action    = var.allowed_actions,
        Resource  = var.resources,
        Condition = var.conditions
      }
    ]
  })
}
