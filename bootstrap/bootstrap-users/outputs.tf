# Output credentials so you can set them up in GitHub/locally
output "github_deploy_user_credentials" {
  value = {
    access_key_id     = aws_iam_access_key.github_deploy_key.id
    secret_access_key = aws_iam_access_key.github_deploy_key.secret
  }
  sensitive = true
}

output "terraform_provisioner_credentials" {
  value = {
    access_key_id     = aws_iam_access_key.terraform_key.id
    secret_access_key = aws_iam_access_key.terraform_key.secret
  }
  sensitive = true
}