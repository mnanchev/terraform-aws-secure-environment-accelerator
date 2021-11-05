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
    #    security = {
    #      email     = "martin2754@gmail.com"
    #      ou        = "Security"
    #      cidr      = ""
    #      create_ou = "true"
    #    }
    #    logging = {
    #      email     = "martin2754@gmail.com"
    #      ou        = "Logging"
    #      cidr      = ""
    #      create_ou = "true"
    #    }
    #    operations = {
    #      email     = "martin2754@gmail.com"
    #      ou        = "Operations"
    #      cidr      = ""
    #      create_ou = "true"
    #    }
    #    backend = {
    #      email     = "martin2754@gmail.com"
    #      ou        = "Backend"
    #      cidr      = ""
    #      create_ou = "true"
    #    }
    #    frontend = {
    #      email     = "martin2754@gmail.com"
    #      ou        = "Frontend"
    #      cidr      = ""
    #      create_ou = "true"
    #    }
    #    database = {
    #      email     = "martin2754@gmail.com"
    #      ou        = "Database"
    #      cidr      = ""
    #      create_ou = "true"
    #    }
    #    ai = {
    #      email     = "martin2754@gmail.com"
    #      ou        = "AI"
    #      cidr      = ""
    #      create_ou = "true"
    #    }
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


variable admin_role{
  default = "AirTrafficControl"
}