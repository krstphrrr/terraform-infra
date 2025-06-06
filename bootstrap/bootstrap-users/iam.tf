# terraform/iam.tf

# 1. GitHub Actions IAM user (for CI/CD)
resource "aws_iam_user" "github_deploy_user" {
  name = "github-deploy-user"
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_access_key" "github_deploy_key" {
  user = aws_iam_user.github_deploy_user.name
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_user_policy" "github_deploy_policy" {
  name = "github-deploy-policy"
  user = aws_iam_user.github_deploy_user.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:*",
          "ecs:*",
          "secretsmanager:GetSecretValue",
          "logs:GetLogEvents",
          "logs:DescribeLogStreams"
        ],
        Resource = "*"
      }
    ]
  })
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_policy" "github_deploy_passrole" {
  name = "GitHubDeployPassRole"
  description = "Allow GitHub Actions to pass ECS task execution role"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "iam:PassRole",
        Resource = local.execution_role_arn
      }
    ]
  })
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_user_policy_attachment" "github_deploy_passrole_attach" {
  user       = aws_iam_user.github_deploy_user.name
  policy_arn = aws_iam_policy.github_deploy_passrole.arn
}

# 2. Terraform local provisioning IAM user
resource "aws_iam_user" "terraform_provisioner" {
  name = "terraform-provisioner"
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_access_key" "terraform_key" {
  user = aws_iam_user.terraform_provisioner.name
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_user_policy" "terraform_policy" {
  name = "terraform-provisioner-policy"
  user = aws_iam_user.terraform_provisioner.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:*",
          "ecs:*",
          "secretsmanager:*",
          "iam:*",
          "ec2:*",
          "logs:*",
          "elasticloadbalancing:*"
        ],
        Resource = "*"
      }
    ]
  })
  lifecycle {
    prevent_destroy = true
  }
}


