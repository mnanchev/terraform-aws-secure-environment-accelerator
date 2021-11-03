# Copyright 2021 Martin Nanchev
module "organization" {
  source = "../modules/0_organization"
}

module "organization_accounts_structure" {
  for_each        = var.organization_structure
  source          = "../modules/1_account"
  account_name    = each.key
  aws_cli_profile = var.profile
  aws_region      = var.region
  customer        = var.customer
  email           = each.value["email"]
  ou              = each.value["ou"]
  parent          = module.organization.root_id
}

module "service_control_policy"{
  source = "../modules/2_scp"
  aws_deny_disabling_security_hub = true
  aws_deny_leaving_org = true
  organization_id = module.organization.organization_id
  aws_region_restrictions = {
    allowed = [var.region]
  }
}

