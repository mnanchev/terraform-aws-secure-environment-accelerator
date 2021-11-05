# Copyright 2021 Martin Nanchev
module "organization" {
  source = "./modules/0_organization"
}

module "organization_accounts_structure" {
  for_each     = var.organization_structure
  source       = "./modules/1_account"
  account_name = each.key
  aws_region   = var.region
  customer     = var.customer
  email        = each.value["email"]
  ou           = each.value["ou"]
  create_ou    = each.value["create_ou"]
  parent       = module.organization.root_id
  admin_role   = var.admin_role
}

module "service_control_policy" {
  source                          = "./modules/2_scp"
  depends_on                      = [module.organization_accounts_structure]
  aws_deny_disabling_security_hub = true
  aws_deny_leaving_org            = true
  organization_id                 = module.organization.organization_id
  allowed_region                  = var.region
}


module "vpc_networking" {
  source = "./modules/3_vpc"
  providers = {
    aws = aws.networking
  }
  depends_on         = [module.organization_accounts_structure]
  enable_nat_gateway = false
  enable_vpn_gateway = false
  name               = "${var.customer}-${local.networking_account}-vpc"
  cidr               = var.organization_structure.networking.cidr
  private_subnets    = slice(cidrsubnets(var.organization_structure.networking.cidr, 8, 8, 8, 8, 12, 12), 3, length(cidrsubnets(var.organization_structure.networking.cidr, 8, 8, 8, 8, 12, 12)))
  public_subnets     = slice(cidrsubnets(var.organization_structure.networking.cidr, 8, 8, 8, 8, 12, 12), 0, 3)
  azs                = [for zone in ["a", "b", "c"] : join("", [var.region, zone])]
  tags = {
    Terraform   = "true"
    Environment = "production"
    Account     = local.networking_account
  }
}

module "share_public_subnet_with_perimeter" {
  count = length(module.vpc_networking.public_subnets)
  providers = {
    aws = aws.networking
  }
  depends_on          = [module.organization_accounts_structure, module.vpc_networking]
  source              = "./modules/5_ram"
  principal           = local.all_ids[lower(var.organization_structure.perimeter.ou)]
  resource_arn        = module.vpc_networking.public_subnets[count.index]
  resource_share_name = "Share public subnets from networking account with perimeter account"
}

module "transit_gateway" {
  source      = "./modules/4_transit_gateway"
  name        = "${var.customer}-${local.networking_account}-tgw"
  description = "Transit gateway in networking account"
  providers = {
    aws = aws.networking
  }
  enable_auto_accept_shared_attachments = true
  depends_on                            = [module.vpc_networking]
  vpc_attachments = {
    vpc = {
      vpc_id       = module.vpc_networking.vpc_id
      subnet_ids   = module.vpc_networking.private_subnets
      dns_support  = true
      ipv6_support = true

      tgw_routes = [
        {
          destination_cidr_block = "0.0.0.0/0"
        }
      ]
    }
  }

  ram_allow_external_principals = true
  ram_principals                = [local.all_ids[lower(var.organization_structure.perimeter.ou)]]

  tags = {
    Terraform   = "true"
    Environment = "production"
    Account     = local.networking_account
  }
}