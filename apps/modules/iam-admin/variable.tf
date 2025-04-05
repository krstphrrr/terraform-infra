variable "name" {
  description = "IAM identity name (user or role)"
  type        = string
}

variable "identity_type" {
  description = "Type of IAM identity to create: 'user' or 'role'"
  type        = string
  validation {
    condition     = contains(["user", "role"], var.identity_type)
    error_message = "identity_type must be 'user' or 'role'"
  }
}

variable "allowed_actions" {
  description = "List of actions to allow"
  type        = list(string)
}

variable "resources" {
  description = "List of resources (ARNs) to allow actions on"
  type        = list(string)
  default     = ["*"]
}

variable "conditions" {
  description = "IAM condition block (optional)"
  type        = any
  default     = {}
}

variable "assume_role_policy" {
  description = "Trust policy for IAM role (only if identity_type is 'role')"
  type        = any
  default     = {}
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
