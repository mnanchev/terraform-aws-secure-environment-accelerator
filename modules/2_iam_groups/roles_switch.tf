// create policies in root account
# Copyright 2021 Martin Nanchev
resource "aws_iam_policy" "role_switch_auditor" {
  name   = "${var.account_name}-auditor"
  policy = format(local.policy_role_switch_template, var.account_id, "reader")
}

resource "aws_iam_policy" "role_switch_developer" {
  name   = "${var.account_name}-developer"
  policy = format(local.policy_role_switch_template, var.account_id, "dev")
}

resource "aws_iam_policy" "role_switch_owner" {
  name   = "${var.account_name}-owner"
  policy = format(local.policy_role_switch_template, var.account_id, "owner")
}

// create groups in root account

resource "aws_iam_group" "auditor" {
  name = "${var.account_name}-auditor"
}

resource "aws_iam_group" "developer" {
  name = "${var.account_name}-developer"
}

resource "aws_iam_group" "owner" {
  name = "${var.account_name}-owner"
}

// attach policies to group in root account

resource "aws_iam_group_policy_attachment" "auditor" {
  group      = aws_iam_group.auditor.name
  policy_arn = aws_iam_policy.role_switch_auditor.arn
}

resource "aws_iam_group_policy_attachment" "dev" {
  // A user in the "dev" group should also be allowed to assume the lower privileged role "reader"
  for_each = {
    auditor   = aws_iam_policy.role_switch_auditor.arn
    developer = aws_iam_policy.role_switch_developer.arn
  }
  group      = aws_iam_group.developer.name
  policy_arn = each.key
}

resource "aws_iam_group_policy_attachment" "owner" {
  // A user in the "owner" group should be allowed to assume all other roles
  for_each = {
    auditor   = aws_iam_policy.role_switch_auditor.arn
    developer = aws_iam_policy.role_switch_developer.arn
    owner     = aws_iam_policy.role_switch_owner.arn
  }
  group      = aws_iam_group.owner.name
  policy_arn = each.key
}

// add users to groups


resource "aws_iam_group_membership" "auditor" {
  group = aws_iam_group.auditor.name
  name  = "${var.account_name}-auditor-membership"
  users = var.auditor_users
}


resource "aws_iam_group_membership" "developer" {
  group = aws_iam_group.developer.name
  name  = "${var.account_name}-dev-membership"
  users = var.developer_users
}


resource "aws_iam_group_membership" "owner" {
  group = aws_iam_group.owner.name
  name  = "${var.account_name}-owner-membership"
  users = var.owner_users
}
