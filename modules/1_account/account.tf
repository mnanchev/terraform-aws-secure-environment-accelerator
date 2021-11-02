#Copyright 2021 Martin Nanchev
resource "aws_organizations_account" "account" {
  name  = var.account_name
  email = var.email
  # Deny access of child accounts to billing
  iam_user_access_to_billing = "DENY"
  # AirTrafficControl role with access to billing
  role_name = "AirTrafficControl"

  lifecycle {
    ignore_changes = [role_name,
      name,
      email,
    iam_user_access_to_billing]
  }
  tags = {
    Name = var.account_name
    "terraform-managed" : true
  }
}

resource "aws_organizations_organizational_unit" "ou" {
  name      = var.ou
  parent_id = var.parent
}