module "terraform_admin_user" {
  source          = "../modules/iam-admin"
  name            = "terraform-admin"
  identity_type   = "user"
  allowed_actions = [
    "iam:*",
    "dynamodb:*",
    "s3:*",
    "ecr:*",
    "ecs:*",
    "logs:*",
    "ec2:*"
  ]
  tags = {
    Role = "Terraform Admin"
  }
}

# example of creating a GitHub OIDC role (commented out for now) with this module
# module "github_oidc_role" {
#   source          = "./modules/iam-admin"
#   name            = "github-deploy-role"
#   identity_type   = "role"

#   assume_role_policy = {
#     Version = "2012-10-17",
#     Statement = [{
#       Effect = "Allow",
#       Principal = {
#         Federated = "arn:aws:iam::123456789012:oidc-provider/token.actions.githubusercontent.com"
#       },
#       Action = "sts:AssumeRoleWithWebIdentity",
#       Condition = {
#         StringEquals = {
#           "token.actions.githubusercontent.com:sub" = "repo:my-org/my-repo:ref:refs/heads/main"
#         }
#       }
#     }]
#   }

#   allowed_actions = [
#     "ecs:*",
#     "ecr:*",
#     "logs:*"
#   ]

#   resources = ["*"]

#   tags = {
#     Project = "GitHub Deployments"
#   }
# }

provider "aws" {
  region  = "us-east-1"
  profile = "bootstrap"  # using the profile tied to your root credentials for now
}

output "terraform_admin_access_key_id" {
  value     = module.terraform_admin_user.access_key.id
  sensitive = true
}

output "terraform_admin_secret_key" {
  value     = module.terraform_admin_user.access_key.secret
  sensitive = true
}