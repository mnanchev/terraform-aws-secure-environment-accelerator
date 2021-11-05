variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "customer" {
  type        = string
  description = "Customer name"
}

variable "email" {
  type        = string
  description = "Email for the account creation"
}

variable "account_name" {
  type        = string
  description = "Name of teh account that will be created"
}

variable "ou" {
  description = "Name of organizational unit"
}

variable "parent" {
  description = "This is the parent for the OU creation"
}

variable "create_ou" {
  description = "If the an OU should be created or you will specify ou_id in which the account will live"
}

variable "ou_id" {
  default     = ""
  description = "Parent Organizational Unit ID or Root ID for the account. Defaults to the Organization default Root ID. A configuration must be present for this argument to perform drift detection"
}

variable "admin_role" {
  description = "The admin role that will be created in other accounts. It is possible to assume it and access the child accounts from root"
}