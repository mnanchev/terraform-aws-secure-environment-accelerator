# Provides a resource to create an AWS organization.
# Copyright 2021 Martin Nanchev
resource "aws_organizations_organization" "organization" {
  # List of AWS service principal names for which
  # you want to enable integration with your organization
  aws_service_access_principals = var.aws_service_access_principals
  feature_set                   = "ALL"
  enabled_policy_types = ["SERVICE_CONTROL_POLICY"]
}

output "root_id" {
  value = aws_organizations_organization.organization.roots[0].id
}