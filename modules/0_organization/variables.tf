variable "aws_service_access_principals" {
  type = list(string)
  default = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
    "backup.amazonaws.com",
    "compute-optimizer.amazonaws.com",
    "fms.amazonaws.com",
    "guardduty.amazonaws.com",
    "health.amazonaws.com",
    "macie.amazonaws.com",
    "securityhub.amazonaws.com",
    "ram.amazonaws.com",
    "servicequotas.amazonaws.com",
    "sso.amazonaws.com",
    "ssm.amazonaws.com",
    "tagpolicies.tag.amazonaws.com",
    "reporting.trustedadvisor.amazonaws.com"
  ]
}

variable "features" {
  type    = string
  default = "ALL"

}