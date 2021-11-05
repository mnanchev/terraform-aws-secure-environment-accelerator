output "organization_id" {
  value = aws_organizations_organization.organization.roots.0.id
}

output "non_master_accounts" {
  value = aws_organizations_organization.organization.non_master_accounts
}