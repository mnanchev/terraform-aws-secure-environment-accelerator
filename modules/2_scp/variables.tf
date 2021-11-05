

variable "aws_deny_disabling_security_hub" {
  type        = bool
  default     = true
  description = "Enable SCP that denies accounts the ability to disable Security Hub"
}

variable "aws_deny_leaving_org" {
  type        = bool
  default     = true
  description = "Enable SCP that denies accounts the ability to leave the AWS organisation"
}

variable "organization_id" {
  type        = string
  description = "ID of the Organization"
}

variable "allowed_region" {
  type        = string
  description = "Allowed regions to create resources in"
}