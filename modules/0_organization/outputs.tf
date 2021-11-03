output "organization_id" {
  value = aws_organizations_organization.organization.roots.0.id
}