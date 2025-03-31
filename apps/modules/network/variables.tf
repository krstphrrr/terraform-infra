variable "project_name" {
  description = "Name prefix for all resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
}

variable "availability_zone" {
  description = "AZ for subnet"
  type        = string
}

variable "ingress_port" {
  description = "Ingress port to allow in security group"
  type        = number
}

variable "public_subnet_cidr_b" {
  type        = string
  description = "CIDR block for second public subnet"
  default     = null
}

variable "availability_zone_b" {
  type        = string
  description = "Second AZ for public subnet"
  default     = null
}