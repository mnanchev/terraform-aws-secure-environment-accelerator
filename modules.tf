# Copyright 2021 Martin Nanchev
module "organization" {
  source = "./modules/0_organization"
}

module "organization_accounts_structure" {
  for_each        = var.organization_structure
  source          = "./modules/1_account"
  account_name    = each.key
  aws_cli_profile = var.profile
  aws_region      = var.region
  customer        = var.customer
  email           = each.value["email"]
  ou              = each.value["ou"]
  create_ou       = each.value["create_ou"]
  parent          = module.organization.root_id
  admin_role      = var.admin_role
}

module "service_control_policy" {
  source                          = "./modules/2_scp"
  depends_on                      = [module.organization_accounts_structure]
  aws_deny_disabling_security_hub = true
  aws_deny_leaving_org            = true
  organization_id                 = module.organization.organization_id
}


#module "vpc_networking" {
#  source = "./modules/3_vpc"
#  providers = {
#    aws = aws.networking
#  }
#  depends_on = [module.organization_accounts_structure]
#  enable_nat_gateway = false
#  enable_vpn_gateway = false
#  name               = "${var.customer}-${local.networking_account}-vpc"
#  cidr               = var.organization_structure.networking.cidr
#  private_subnets    = slice(cidrsubnets(var.organization_structure.networking.cidr, 8, 8, 8, 8, 12, 12), 3, length(cidrsubnets(var.organization_structure.networking.cidr, 8, 8, 8, 8, 12, 12)))
#  public_subnets     = slice(cidrsubnets(var.organization_structure.networking.cidr, 8, 8, 8, 8, 12, 12), 0, 3)
#  azs                = [for zone in ["a", "b", "c"] : join("", [var.region, zone])]
#  tags = {
#    Terraform   = "true"
#    Environment = "production"
#    Account     = local.networking_account
#  }
#}
#
#module "vpc_perimeter" {
#  source = "./modules/3_vpc"
#  providers = {
#    aws = aws.networking
#  }
#  enable_nat_gateway = true
#  enable_vpn_gateway = true
#  single_nat_gateway = true
#  name               = "${var.customer}-${local.perimeter_account}-vpc"
#  cidr               = var.organization_structure.perimeter.cidr
#  private_subnets    = slice(cidrsubnets(var.organization_structure.perimeter.cidr, 8, 8, 8, 8, 12, 12), 3, length(cidrsubnets(var.organization_structure.perimeter.cidr, 8, 8, 8, 8, 12, 12)))
#  public_subnets     = slice(cidrsubnets(var.organization_structure.perimeter.cidr, 8, 8, 8, 8, 12, 12), 0, 3)
#  azs                = [for zone in ["a", "b", "c"] : join("", [var.region, zone])]
#  tags = {
#    Terraform   = "true"
#    Environment = "production"
#    Account     = local.perimeter_account
#  }
#}
