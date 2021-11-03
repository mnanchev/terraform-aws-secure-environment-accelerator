locals {
  enabled_root_policies = {
    allowed_regions = {
      enable = var.aws_region_restrictions != null ? true : false
      policy = var.aws_region_restrictions != null ? templatefile("${path.module}/templates/allowed_regions.json.tpl", {
        allowed    = var.aws_region_restrictions
      }) : null
    }
    cloudtrail_log_stream = {
      enable = true
      policy = file("${path.module}/templates/cloudtrail_log_stream.json")
    }
    deny_disabling_security_hub = {
      enable = var.aws_deny_disabling_security_hub
      policy = file("${path.module}/templates/deny_disabling_security_hub.json")
    }
    deny_leaving_org = {
      enable = var.aws_deny_leaving_org
      policy = file("${path.module}/templates/deny_leaving_org.json")
    }
  }
  root_policies_to_merge = [for key, value in local.enabled_root_policies : jsondecode(
  value.enable == true ? value.policy : "{\"Statement\": []}"
  )]

  root_policies_merged = flatten([
  for policy in local.root_policies_to_merge : policy
  ])
}
