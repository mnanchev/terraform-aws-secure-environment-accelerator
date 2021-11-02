# Provides a resource to create an AWS organization.
resource "aws_organizations_organization" "organization" {
  # List of AWS service principal names for which
  # you want to enable integration with your organization
  aws_service_access_principals = var.aws_service_access_principals
  feature_set                   = "ALL"
}

output "root_id" {
  value = aws_organizations_organization.organization.roots[0].id
}