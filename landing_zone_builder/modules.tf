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

#module "iam_groups" {
#  source = "../modules/2_iam_groups"
#  account_id = ""
#  account_name = ""
#  auditor_users = ""
#  developer_users = ""
#  owner_users = ""
#}


