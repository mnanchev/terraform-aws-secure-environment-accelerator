variable "organization_structure" {
  type        = map(map(any))
  description = "The variable controls how the OUs and accounts will created\n The key of the map are the accounts, which will be created inside the ou, which is added as parameter"
  default = {
    networking = {
      email     = "martin.nanchev@adesso.bg"
      ou        = "Networking"
      cidr      = "10.1.0.0/16"
      create_ou = "true"
    }
    perimeter = {
      email     = "martin2754@icloud.com"
      ou        = "Perimeter"
      cidr      = "10.0.0.0/16"
      create_ou = "true"
    }
  }
}

variable "customer" {
  default = "sea"
}

variable "profile" {
  default = "profile"
}

variable "region" {
  default = "us-east-1"
}


variable "admin_role" {
  default = "AirTrafficControl"
}