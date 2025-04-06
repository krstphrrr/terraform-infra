provider "aws" {
  region  = var.aws_region
  profile = "terraform-admin"
}

# terraform {
#   backend "s3" {
#     bucket         = "tf-state-bucket1-a1b2c3d4" 
#     key            = "bootstrap/bootstrap-users/terraform.tfstate"   
#     region         = "us-east-1"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }