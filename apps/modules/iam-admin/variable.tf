variable "name" {
  type        = string
  description = "IAM user name"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to IAM user"
}

variable "allowed_actions" {
  type        = list(string)
  description = "List of IAM actions to allow"
}

