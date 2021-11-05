#Copyright 2021 Martin Nanchev
resource "aws_organizations_organizational_unit" "ou" {
  count     = var.create_ou ? 1 : 0
  name      = var.ou
  parent_id = var.parent
}

resource "aws_organizations_account" "account" {
  name  = var.account_name
  email = var.email
  # Deny access of child accounts to billing
  iam_user_access_to_billing = "DENY"
  # AirTrafficControl role with access to billing
  role_name = var.admin_role
  parent_id = var.create_ou ? aws_organizations_organizational_unit.ou[0].id : var.ou_id
  lifecycle {
    ignore_changes = [role_name,
      name,
      email,
    iam_user_access_to_billing]
  }
  tags = {
    Name      = var.account_name
    Terraform = true
  }
}
