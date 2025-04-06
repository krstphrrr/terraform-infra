module "bootstrap_users" {
  source = "./bootstrap-users"
}


output "github_deploy_user_credentials" {
  value     = module.bootstrap_users.github_deploy_user_credentials
  sensitive = true
}

output "terraform_provisioner_credentials" {
  value     = module.bootstrap_users.terraform_provisioner_credentials
  sensitive = true
}

