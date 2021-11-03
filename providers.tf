provider "aws" {
  region = var.region
}

provider "aws" {
  alias  = "networking"
  region = var.region

  assume_role {
    # Switch into the account we created in this module
    role_arn = "arn:aws:iam::${all_ids[lower(var.organization_structure.networking.ou)]}:role/${air_traffic_control[lower(var.organization_structure.networking.ou)]}"
  }
}

provider "aws" {
  alias  = "security"
  region = var.region

  assume_role {
    # Switch into the account we created in this module
    role_arn = "arn:aws:iam::${all_ids[lower(var.organization_structure.security.ou)]}:role/${air_traffic_control[lower(var.organization_structure.security.ou)]}"
  }
}

provider "aws" {
  alias  = "logging"
  region = var.region

  assume_role {
    # Switch into the account we created in this module
    role_arn = "arn:aws:iam::${all_ids[lower(var.organization_structure.logging.ou)]}:role/${air_traffic_control[lower(var.organization_structure.logging.ou)]}"
  }
}

provider "aws" {
  alias  = "perimeter"
  region = var.region

  assume_role {
    # Switch into the account we created in this module
    role_arn = "arn:aws:iam::${all_ids[lower(var.organization_structure.perimeter.ou)]}:role/${air_traffic_control[lower(var.organization_structure.perimeter.ou)]}"
  }
}

provider "aws" {
  alias  = "operations"
  region = var.region

  assume_role {
    # Switch into the account we created in this module
    role_arn = "arn:aws:iam::${all_ids[lower(var.organization_structure.operations.ou)]}:role/${lower(var.organization_structure.operations.ou)}"
  }
}

provider "aws" {
  alias  = "ai"
  region = var.region

  assume_role {
    # Switch into the account we created in this module
    role_arn = "arn:aws:iam::${all_ids[lower(var.organization_structure.ai.ou)]}:role/${air_traffic_control[lower(var.organization_structure.ai.ou)]}"
  }
}

provider "aws" {
  alias  = "backend"
  region = var.region

  assume_role {
    # Switch into the account we created in this module
    role_arn = "arn:aws:iam::${all_ids[lower(var.organization_structure.backend.ou)]}:role/${air_traffic_control[lower(var.organization_structure.backend.ou)]}"
  }
}

provider "aws" {
  alias  = "frontend"
  region = var.region


  assume_role {
    # Switch into the account we created in this module
    role_arn = "arn:aws:iam::${all_ids[lower(var.organization_structure.frontend.ou)]}:role/${air_traffic_control[lower(var.organization_structure.frontend.ou)]}"
  }
}

provider "aws" {
  alias  = "database"
  region = var.region

  assume_role {
    # Switch into the account we created in this module
    role_arn = "arn:aws:iam::${all_ids[lower(var.organization_structure.database.ou)]}:role/${air_traffic_control[lower(var.organization_structure.database.ou)]}"
  }
}