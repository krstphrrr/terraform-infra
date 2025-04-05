module "terraform_admin_user" {
  source          = "../modules/iam-admin"  # adjust if needed
  name            = "terraform-admin"
  allowed_actions = [
    "iam:*",
    "s3:*",
    "dynamodb:*",
    "ec2:*",
    "ecr:*",
    "ecs:*",
    "logs:*",
    "secretsmanager:*"
  ]
  tags = {
    Owner   = "Infrastructure"
    Project = "Terraform Admin"
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "bootstrap"  # using the profile tied to your root credentials for now
}

output "terraform_admin_access_key" {
  value     = module.terraform_admin_user.access_key_id
  sensitive = true
}

output "terraform_admin_secret_key" {
  value     = module.terraform_admin_user.secret_access_key
  sensitive = true
}
