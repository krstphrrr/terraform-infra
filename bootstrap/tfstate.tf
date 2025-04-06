module "tfstate" {
  source              = "./s3-tfstate"
  bucket_name         = "tf-state-bucket1-a1b2c3d4"
  dynamodb_table_name = "terraform-locks"
  enable_locking      = true

  tags = {
    Project = "TerraformBootstrap"
  }
}

output "s3_bucket" {
  value = module.tfstate.s3_bucket
}

output "dynamodb_table" {
  value = module.tfstate.dynamodb_table
}

