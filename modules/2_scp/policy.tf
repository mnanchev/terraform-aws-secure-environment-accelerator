resource "aws_organizations_policy" "sea_root_policies" {
  name = "SecureEnvironmentAccelerator-RootPolicies"
  content = jsonencode({
    Version   = "2012-10-17"
    Statement = templatefile("${path.module}/templates/allowed_regions.json.tpl", {
      allowed    = var.aws_region_restrictions
    })
  })
  description = "SecureEnvironmentAccelerator enabled Root OU policies"
}

resource "aws_organizations_policy_attachment" "lz_root_policies" {
  policy_id = aws_organizations_policy.sea_root_policies.id
  target_id = var.organization_id
}