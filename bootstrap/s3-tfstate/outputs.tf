output "s3_bucket" {
  value = aws_s3_bucket.tfstate.bucket
}

output "dynamodb_table" {
  value = var.enable_locking ? aws_dynamodb_table.tfstate_lock[0].name : null
}
