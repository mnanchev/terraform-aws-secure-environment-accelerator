resource "aws_organizations_policy" "sea_root_policies" {
  name = "secure-environment-accelerator-guardrails"
  content = jsonencode({
    Version   = "2012-10-17"
    Statement = local.root_policies_merged
  })
  description = "SecureEnvironmentAccelerator enabled Root OU policies"
}

resource "aws_organizations_policy_attachment" "lz_root_policies" {
  policy_id = aws_organizations_policy.sea_root_policies.id
  target_id = var.organization_id
}