variable "bucket_name" {
  description = "Name of the S3 bucket to store tfstate"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Name of DynamoDB table for state locking"
  type        = string
  default     = "terraform-locks"
}

variable "enable_locking" {
  description = "Whether to create the DynamoDB locking table"
  type        = bool
  default     = true
}

variable "tags" {
  type    = map(string)
  default = {
    ManagedBy = "Terraform"
  }
}
