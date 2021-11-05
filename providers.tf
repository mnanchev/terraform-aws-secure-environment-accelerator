provider "aws" {
  profile = var.profile
  region  = var.region
}

provider "aws" {
  alias   = "networking"
  region  = var.region
  profile = var.profile
  assume_role {
    # Switch into the account we created in this module
    role_arn = "arn:aws:iam::${local.all_ids[lower(var.organization_structure.networking.ou)]}:role/${var.admin_role}"
  }
}

#provider "aws" {
#  alias   = "security"
#  region  = var.region
#  profile = var.profile
#  assume_role {
#    # Switch into the account we created in this module
#    role_arn = "arn:aws:iam::${local.all_ids[lower(var.organization_structure.security.ou)]}:role/${local.air_traffic_control[lower(var.organization_structure.security.ou)]}"
#  }
#}
#
#provider "aws" {
#  alias   = "logging"
#  region  = var.region
#  profile = var.profile
#  assume_role {
#    # Switch into the account we created in this module
#    role_arn = "arn:aws:iam::${local.all_ids[lower(var.organization_structure.logging.ou)]}:role/${local.air_traffic_control[lower(var.organization_structure.logging.ou)]}"
#  }
#}
#
provider "aws" {
  alias   = "perimeter"
  region  = var.region
  profile = var.profile
  assume_role {
    # Switch into the account we created in this module
    role_arn = "arn:aws:iam::${local.all_ids[lower(var.organization_structure.perimeter.ou)]}:role/${local.air_traffic_control[lower(var.organization_structure.perimeter.ou)]}"
  }
}
#
#provider "aws" {
#  alias   = "operations"
#  region  = var.region
#  profile = var.profile
#  assume_role {
#    # Switch into the account we created in this module
#    role_arn = "arn:aws:iam::${local.all_ids[lower(var.organization_structure.operations.ou)]}:role/${lower(var.organization_structure.operations.ou)}"
#  }
#}
#
#provider "aws" {
#  alias   = "ai"
#  region  = var.region
#  profile = var.profile
#  assume_role {
#    # Switch into the account we created in this module
#    role_arn = "arn:aws:iam::${local.all_ids[lower(var.organization_structure.ai.ou)]}:role/${local.air_traffic_control[lower(var.organization_structure.ai.ou)]}"
#  }
#}
#
#provider "aws" {
#  alias   = "backend"
#  region  = var.region
#  profile = var.profile
#  assume_role {
#    # Switch into the account we created in this module
#    role_arn = "arn:aws:iam::${local.all_ids[lower(var.organization_structure.backend.ou)]}:role/${local.air_traffic_control[lower(var.organization_structure.backend.ou)]}"
#  }
#}
#
#provider "aws" {
#  alias  = "frontend"
#  region = var.region
#
#  profile = var.profile
#  assume_role {
#    # Switch into the account we created in this module
#    role_arn = "arn:aws:iam::${local.all_ids[lower(var.organization_structure.frontend.ou)]}:role/${local.air_traffic_control[lower(var.organization_structure.frontend.ou)]}"
#  }
#}
#
#provider "aws" {
#  alias   = "database"
#  region  = var.region
#  profile = var.profile
#  assume_role {
#    # Switch into the account we created in this module
#    role_arn = "arn:aws:iam::${local.all_ids[lower(var.organization_structure.database.ou)]}:role/${local.air_traffic_control[lower(var.organization_structure.database.ou)]}"
#  }
#}