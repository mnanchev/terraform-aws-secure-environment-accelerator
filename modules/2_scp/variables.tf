variable "aws_region_restrictions" {
  type = object({
    allowed = list(string)
  })
  default     = { allowed = ["us-east-1"] }
  description = "List of allowed AWS regions and principals that are exempt from the restriction"
}

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
