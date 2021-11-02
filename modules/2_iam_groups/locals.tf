locals {
  // The policy is the same for all roles, so we read it once to stay DRY
  // It allows the root account to switch to these roles
  policy_assume_role = templatefile("${path.module}/policy_assume_role.json.tpl", {
    root_account_id = data.aws_caller_identity.root.account_id
  })
  policy_role_switch_template = file("${path.module}/policy_role_switch.json")
}